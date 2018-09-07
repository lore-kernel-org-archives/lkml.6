Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB13C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C8F204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=easymile.com header.i=@easymile.com header.b="iNSD8Jwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C8F204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=easymile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeIGLIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:08:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40836 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbeIGLIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:08:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id 207-v6so13332282wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 23:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easymile.com; s=easymile;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jIBJ46vwXNcPJqhdtJKI/sAshI4Ao2xwzBVd+GgHKf8=;
        b=iNSD8JwcWwEhxLKqz+zBPIugroOd04loGA3mvVgTWe30Og0OVBEnI+ddcqUiX471To
         RJAnK5uDr1Aik4v3ZfQAgQwxp5d4PpesWpDxu5ukeCIShutJHrIhlKs6yi0yATwvvpfM
         fvLFTb/MR2VKqOvIwUQhhxgdaQ7iwic4Y166o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jIBJ46vwXNcPJqhdtJKI/sAshI4Ao2xwzBVd+GgHKf8=;
        b=ihJ9XHbawtuwtm0+nbOX+pIid8xGR0FnkiGlUlPPNYwIqCWRHJh9kdmjn7ID2EM3NB
         eIMR5zdtZfied1Iri5WwecQKY707S43/ESBTkspNoNf1MRsvxwen1+fO10l3DVrkS2/O
         gMDknvSrD0qmm8c0V6pInP08EqcA4AFjgTxK9KCOHAuQ/M9gbB7+36PADeFXA4TuGGJW
         3zb1LWzOuUNokY20RpsOlWbkRPD9u70v0XYzuBQi8d/QehUzNpNbsYOBsV0pjdDNFT8m
         m2KQ1L0jLTdRrg6P7iralc3dCaGJ27b4AF2vH7TIJy/vZeLzOLadN5kr64bavQ+8jMWo
         bFCA==
X-Gm-Message-State: APzg51B+RGkczfBOtsXW9vTWMBJIRIriZPgdRYUOOWm4jhxsM1AFJP9u
        uasfVp5q3hkeYkwKW8Hosize3Q==
X-Google-Smtp-Source: ANB0VdaVKhMU5ePL3qQhli3k1T6JkMDKfMGZEb8kCWwJTi0rWXdhxMjCXhkWn8QlmwcM5FJuxzpdLw==
X-Received: by 2002:a1c:ac1:: with SMTP id 184-v6mr4102352wmk.119.1536301734395;
        Thu, 06 Sep 2018 23:28:54 -0700 (PDT)
Received: from super_plancton ([185.116.129.142])
        by smtp.gmail.com with ESMTPSA id 200-v6sm11573588wmv.6.2018.09.06.23.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 23:28:53 -0700 (PDT)
Date:   Fri, 7 Sep 2018 08:28:51 +0200
From:   Camille Bordignon <camille.bordignon@easymile.com>
To:     "Neftin, Sasha" <sasha.neftin@intel.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Netdev <netdev@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] e1000e driver stuck at 10Mbps after
 reconnection
Message-ID: <20180907062851.GA7336@super_plancton>
References: <20180806115913.GA21556@super_plancton>
 <CAKgT0UcUV8bQRAhyevfnvwE+yWnWjwAkH0WumUoUK4Fa9SCzhg@mail.gmail.com>
 <20180807064222.GA30741@super_plancton>
 <001556a4-c49c-b96b-0be8-b3c4be7bb09c@intel.com>
 <c1e2cf13-6bcc-498d-03ea-7c3792d675cb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1e2cf13-6bcc-498d-03ea-7c3792d675cb@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 08 août 2018 à 18:00:28 (+0300), Neftin, Sasha a écrit :
> On 8/8/2018 17:24, Neftin, Sasha wrote:
> > On 8/7/2018 09:42, Camille Bordignon wrote:
> > > Le lundi 06 août 2018 à 15:45:29 (-0700), Alexander Duyck a écrit :
> > > > On Mon, Aug 6, 2018 at 4:59 AM, Camille Bordignon
> > > > <camille.bordignon@easymile.com> wrote:
> > > > > Hello,
> > > > > 
> > > > > Recently we experienced some issues with intel NIC (I219-LM
> > > > > and I219-V).
> > > > > It seems that after a wire reconnection, auto-negotation "fails" and
> > > > > link speed drips to 10 Mbps.
> > > > > 
> > > > >  From kernel logs:
> > > > > [17616.346150] e1000e: enp0s31f6 NIC Link is Down
> > > > > [17627.003322] e1000e: enp0s31f6 NIC Link is Up 10 Mbps Full
> > > > > Duplex, Flow Control: None
> > > > > [17627.003325] e1000e 0000:00:1f.6 enp0s31f6: 10/100 speed:
> > > > > disabling TSO
> > > > > 
> > > > > 
> > > > > $ethtool enp0s31f6
> > > > > Settings for enp0s31f6:
> > > > >          Supported ports: [ TP ]
> > > > >          Supported link modes:   10baseT/Half 10baseT/Full
> > > > >                                  100baseT/Half 100baseT/Full
> > > > >                                  1000baseT/Full
> > > > >          Supported pause frame use: No
> > > > >          Supports auto-negotiation: Yes
> > > > >          Supported FEC modes: Not reported
> > > > >          Advertised link modes:  10baseT/Half 10baseT/Full
> > > > >                                  100baseT/Half 100baseT/Full
> > > > >                                  1000baseT/Full
> > > > >          Advertised pause frame use: No
> > > > >          Advertised auto-negotiation: Yes
> > > > >          Advertised FEC modes: Not reported
> > > > >          Speed: 10Mb/s
> > > > >          Duplex: Full
> > > > >          Port: Twisted Pair
> > > > >          PHYAD: 1
> > > > >          Transceiver: internal
> > > > >          Auto-negotiation: on
> > > > >          MDI-X: on (auto)
> > > > >          Supports Wake-on: pumbg
> > > > >          Wake-on: g
> > > > >          Current message level: 0x00000007 (7)
> > > > >                                 drv probe link
> > > > >          Link detected: yes
> > > > > 
> > > > > 
> > > > > Notice that if disconnection last less than about 5 seconds,
> > > > > nothing wrong happens.
> > > > > And if after last failure, disconnection / connection occurs again and
> > > > > last less than 5 seconds, link speed is back to 1000 Mbps.
> > > > > 
> > > > > [18075.350678] e1000e: enp0s31f6 NIC Link is Down
> > > > > [18078.716245] e1000e: enp0s31f6 NIC Link is Up 1000 Mbps
> > > > > Full Duplex, Flow Control: None
> > > > > 
> > > > > The following patch seems to fix this issue.
> > > > > However I don't clearly understand why.
> > > > > 
> > > > > diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> > > > > b/drivers/net/ethernet/intel/e1000e/netdev.c
> > > > > index 3ba0c90e7055..763c013960f1 100644
> > > > > --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> > > > > +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> > > > > @@ -5069,7 +5069,7 @@ static bool e1000e_has_link(struct
> > > > > e1000_adapter *adapter)
> > > > >          case e1000_media_type_copper:
> > > > >                  if (hw->mac.get_link_status) {
> > > > >                          ret_val = hw->mac.ops.check_for_link(hw);
> > > > > -                       link_active = !hw->mac.get_link_status;
> > > > > +                       link_active = false;
> > > > >                  } else {
> > > > >                          link_active = true;
> > > > >                  }
> > > > > 
> > > > > Maybe this is related to watchdog task.
> > > > > 
> > > > > I've found out this fix by comparing with last commit that works fine :
> > > > > commit 0b76aae741abb9d16d2c0e67f8b1e766576f897d.
> > > > > However I don't know if this information is relevant.
> > > > > 
> > > > > Thank you.
> > > > > Camille Bordignon
> > > > 
> > > > What kernel were you testing this on? I know there have been a number
> > > > of changes over the past few months in this area and it would be
> > > > useful to know exactly what code base you started out with and what
> > > > the latest version of the kernel is you have tested.
> > > > 
> > > > Looking over the code change the net effect of it should be to add a 2
> > > > second delay from the time the link has changed until you actually
> > > > check the speed/duplex configuration. It is possible we could be
> > > > seeing some sort of timing issue and adding the 2 second delay after
> > > > the link event is enough time for things to stabilize and detect the
> > > > link at 1000 instead of 10/100.
> > > > 
> > > > - Alex
> > > 
> > > We've found out this issue using Fedora 27 (4.17.11-100.fc27.x86_64).
> > > 
> > > Then I've tested wth a more recent version of the driver v4.18-rc7 but
> > > behavior looks the same.
> > > 
> > > Thanks for you reply.
> > > 
> > > Camille Bordignon
> > > _______________________________________________
> > > Intel-wired-lan mailing list
> > > Intel-wired-lan@osuosl.org
> > > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> > > 
> > I've agree with Alex. Let's try add 2s delay after a link event. Please,
> > let us know if it will solve your problem.
> > Also, I would like recommend try work with different link partner and
> > see if you see same problem.
> > _______________________________________________
> > Intel-wired-lan mailing list
> > Intel-wired-lan@osuosl.org
> > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> Camille,
> My apologies, I wrong understand Alex. Please, do not try add delay. Please,
> check if you see same problem with different link partners.
> Thanks,
> Sasha
Hello,

I recently figured out that neither the previous patch nor commit
0b76aae741abb9d16d2c0e67f8b1e766576f897d fix this issue.

In these cases, after reproducing the issue, when ethernet wire is connected
kernel logs mention full speed (1000 Mbps) but actually it seems it is not.
The problem persists.

I made some simple tests with a web browser and a dowload speed test
site (fast.com). As a result speed was always around 8 Mbps.

And again after a quick ethernet wire disconnection / reconnection, same
test is around 500 Mbps.

I feel very confused.

Camille Bordignon
