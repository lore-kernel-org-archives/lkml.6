Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ED3ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D879F21486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUb2Ey/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D879F21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeJTDc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:32:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33490 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbeJTDc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:32:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id z21-v6so31808599ljz.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 12:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E/m2M7NuDjJZn42w4daNSsz+PfNZm80IWeFWNHfUdlU=;
        b=eUb2Ey/1ZMAnX+eKEVmG0ZVuTDeGYoge5gCCNs2bkKD5mqM43GkbOFVXkT1farZXFM
         PE70+CTOQCD2cDcHRc+kdsDJdWe0ZEtsGnXbulq4YR90OTm4vtbzZaZDnlaYFIIEKfww
         cFNQx8bq6Y7lI+lNW1y5BUQoNWAeDi8GsTJxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=E/m2M7NuDjJZn42w4daNSsz+PfNZm80IWeFWNHfUdlU=;
        b=EhsUvQ1uv8eAvtoEvEvPbMOV/5dSIbH9N3m87sflRLnyrMJiMKiP9Ei9oq1ls1mGt2
         IA2r3hq+OyFj1inXW0O3LneKC+vmdoopSxzqvx2WE+0ndUFzb6qDZk7+wq7f7NhRSo7v
         2cL42pUHdCqJIWT7/jOzNxEKrldmq15v0K1vmgnNwaccLZPBhk2ygIqvptwmkxviz80n
         8ubZBJ1vhJtJdu0UyMd4XbQOsV8BkAuMuj0d5UIkDC6CCgrlHx4SQ6B+y1BQl67waJrZ
         aSz8StZh2Ir7cVMT2oY4URvjv6X7RRkBl/fQozF4NKpD1Py5Jxez6VbuxUlymcGo3sAu
         umRQ==
X-Gm-Message-State: ABuFfojvqietRxJIku5cjlGkE4agzluiKd5B1nZA62x77uk1THcp5hik
        a50hw5pS/8eqDm4OYmqJfkGNhA==
X-Google-Smtp-Source: ACcGV600AM7iUbjH7qX/nInS05Eo8rwJizZCB2LHsTaCMSf52G8jiRvfiwThspVI+n7ndRIhIfje9A==
X-Received: by 2002:a2e:215a:: with SMTP id h87-v6mr25727731ljh.102.1539977098179;
        Fri, 19 Oct 2018 12:24:58 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id h21-v6sm432326lfh.38.2018.10.19.12.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 12:24:57 -0700 (PDT)
Date:   Fri, 19 Oct 2018 22:24:55 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: don't flush mcast
 entries while switch promisc mode
Message-ID: <20181019192453.GC3909@khorivan>
Mail-Followup-To: Grygorii Strashko <grygorii.strashko@ti.com>,
        davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181018180006.7065-1-ivan.khoronzhuk@linaro.org>
 <6c34a3ce-dbee-538e-bda7-8dd485315267@ti.com>
 <20181019120408.GA3909@khorivan>
 <36da9bb2-38b7-cc70-9569-8895e20c6d1f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36da9bb2-38b7-cc70-9569-8895e20c6d1f@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 12:23:28PM -0500, Grygorii Strashko wrote:
>
>
>On 10/19/18 7:04 AM, Ivan Khoronzhuk wrote:
>>On Thu, Oct 18, 2018 at 07:03:06PM -0500, Grygorii Strashko wrote:
>>>
>>>
>>>On 10/18/18 1:00 PM, Ivan Khoronzhuk wrote:
>>>>No need now to flush mcast entries in switch mode while toggling to
>>>>promiscuous mode. It's not needed as vlan reg_mcast = ALL_PORTS
>>>>and mcast/vlan ports = ALL_PORTS, the same happening for vlan
>>>>unreg_mcast, it's set to ALL_PORT_MASK just after calling promisc
>>>>mode routine by calling set allmulti. I suppose main reason to flush
>>>>them is to use unreg_mcast to receive all to host port. Thus, now, all
>>>>mcast packets are received anyway and no reason to flush mcast entries
>>>>unsafely, as they were synced with __dev_mc_sync() previously and are
>>>>not restored. Another way is to _dev_mc_unsync() them, but no need.
>>>
>>>User have possibility to add additional mcast entries or edit 
>>>existing in switch-mode, which is now done using custom tool. So, 
>>>Host in promisc
>>>mode will not receive packets for mcast address X if port mask for this
>>>addr set to (ALL_PORTS - HOST_PORT). Am I missing smth?
>>
>>I didn't take into account the custom tool changing entries directly,
>>but even in this case there is at least a couple of interesting
>>questions:
>>
>>1) Before the patch applied only several days ago -
>>   5da1948969bc1991920987ce4361ea56046e5a98
>>   "ti: cpsw: fix lost of mcast packets while rx_mode update"
>>   It was impossible to do correctly anyway, as all mcast entries not
>>   in the mc list were flushed (after rx_mode cb), by:
>>   cpsw_ale_flush_multicast(cpsw->ale, ALE_ALL_PORTS, vid);
>>   and those in mc, rewritten by adding them back in corrected form.
>>   ... or this cb was not supposed to be called at all ...
>
>It's not allowed to manipulate ALE table in dual_mac mode, so your
>patches are safe in dual_mac mode. For switch-mode (unless we  move
>forward with switch dev) standard linux interfaces allows create
>default mcast entries which then (if required) corrected using custom
>tool now.
It's not related to my patches at all, this as it was from very beginning.
My proposition with __dev_mc_unsync(priv->ndev, NULL) is safe as for
dual_mac mode as for switch mode.

>
>>
>>2) What is the reason to add mcast switch entires
>>   (ALL_PORTS - HOST_PORT) if its function is added anyway by
>>   unreq_mcast & (ALL_PORTS - HOST_PORT) ?
>>   So, doesn't matter it's added or not - it will work :-|.
>
>because in switch mode not all traffic directed to the Host port -
No objections, that's exactly I'm talking about here, only p1&p2.
And looks like you forgot about single port board reusing switch
implementation, which by fact is not a switch but reuse this code.
Proposition to flush all its mcast table w/o restore - softly
speaking isn't best choice.

>only in promisc mode. Reason safety and performance - Host should not
>receive traffic which is not designated for it.
Any objections.

>
>promiscuous in switch mode:
>- disables learning
>- enables unicast flooding to Host port
>- enables unregistered multi-cast flooding to the Host port
>In other words, CPSW will continue forwarding packets between P1&P2, 
>but also will "duplicate" packets to Host port. This will work only 
>for
>vlans which have host port as member.
Sorry, but what part was not clearly described in the cover letter?
If you mean vlan entries added not by linux (linux vlans have host
port), and having no host port as a memeber - flush() hasn't been
helping in this case also.

>
>>
>>3) Even so, toggling promisc mode will clear all these changes anyway,
>>   even I will call _dev_mc_unsync() after flushing them.
>
>there can be records which are not under control of Linux now.
yes, and they are flushed w/o restore (along with linux ones).
that's why fix is needed.

>
>>
>>4) If user can tune ALE table by hand, what stops him do it after moving
>>   to promisc mode, seems he knows what he's doing?
>>
>>5) It could be possible only for not default vlan entries, but mcast
>>   vlan support is not supported yet. Who is gona restore those
>>   entries after promisc off?
>>
>>This behaviour is arguable, and flushing mcast entries can bring more
>>issues then leaving. For me it doesn't matter, I can archive the same
>>by adding after flush one line, it's even shorter:
>>__dev_mc_unsync(priv->ndev, NULL);
>
>Again, unless we move forward with switch dev you can't assume that
>Linux stack has full control over ALE table.
and that's why Linux stack is flushing all not created by it mcast entries...
but this what it was doing w/o my changes ).
after my patch it won't, Look:
- it adds/removes entries under control of linux
- it doesn't touch entries added whoever but not a linux
- it restores only entries added linux
  (it was before also, but with flushing all not related entries..
  ..deleting what you don't want to delete)

>Sry, hence this patch is
>not a fix and can introduce changes in current behavior and cause
>regression reports - NACK.
Sorry but what regression you are talking about, what the problem with
__dev_mc_unsync(priv->ndev, NULL)? after flush? This is more than fix.
Restoring entries that were under control of linux is not a fix?
It doesn't touch anything added by custom tool and restores entries
in mc list like it was before. According to your comments, it seems
absolutely one fix you need, ...and don't forget about BBB with one port.

>
>-- 
>regards,
>-grygorii

-- 
Regards,
Ivan Khoronzhuk
