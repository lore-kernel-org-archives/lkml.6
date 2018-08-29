Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC402C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EEE20880
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vn9YSxom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EEE20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeH2EVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:21:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38319 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725199AbeH2EVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:21:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id e2-v6so1502824pgv.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 17:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ruk87P0PUssj2sdy1N1LRNNiRdXuvFAHqrpId9cTLsc=;
        b=Vn9YSxom1Y448HV6I2CLT/pNfzkbXnSE0tlgeLh9+PkX6btIgcAODxt3JHx/vPJUH9
         bwqFyLNC6CGJNbEzqQd3KK6/rKSvsz+y2ci5Vdvlf6VOLdxudrviiku8FAc6UPReBXsh
         dj9piv58T1TtsglKRN5yX62AChaxUnAlfBTfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ruk87P0PUssj2sdy1N1LRNNiRdXuvFAHqrpId9cTLsc=;
        b=hjpYbrDv1zcsL7Qkfeme+r3DAd1GWR1LnlIcic4kSgBDCL9Z2XQcUjZ8yddttuFQqG
         nHLM5GRrg/UrrJISdSlF8WoEmB7CkR1xX2cfomCunIdcc5NXDjMQBYCr31btBb2bZjt8
         vnViXaRFIRWb13hRqF8xjslzJc3JXLnop8UdC86uDRnWHrf1aeaPyhneShMfwkJKQPfr
         ajDYH8RAXD+dfhQ1fP66zh7m+XhsNTF6HbLgXMDcS27+Up8/slYqfGixjS6ZeocrhhkX
         X9mjuF/TkV68yHUqKOu49IXHL0YWShNf+kRbTYuict3IXkVSqof1iBo59gHq61g9QkcU
         7sJw==
X-Gm-Message-State: APzg51A6TXv3pvPpL8ooEkk7JOcdQ+TSAsA2kfQcufaV6ury8kpw7iFD
        FeE8SAGKHzRhk+oxQ3q/onpQzg==
X-Google-Smtp-Source: ANB0Vda0imK88+JAEjo5ovOPJP25B6L7g8VHws8KWq7zcitdk5POpVznjMku9m6ARdf2np0ERHGmbQ==
X-Received: by 2002:a63:ef10:: with SMTP id u16-v6mr3584074pgh.269.1535502459349;
        Tue, 28 Aug 2018 17:27:39 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id h10-v6sm3581306pfj.78.2018.08.28.17.27.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 17:27:38 -0700 (PDT)
Date:   Wed, 29 Aug 2018 09:28:00 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Dave Young <dyoung@redhat.com>
Cc:     Pingfan Liu <piliu@redhat.com>, Philipp Rudo <prudo@linux.ibm.com>,
        catalin marinas <catalin.marinas@arm.com>,
        will deacon <will.deacon@arm.com>, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, bhe@redhat.com, arnd@arndb.de,
        schwidefsky@de.ibm.com, heiko carstens <heiko.carstens@de.ibm.com>,
        ard biesheuvel <ard.biesheuvel@linaro.org>,
        james morse <james.morse@arm.com>, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "piliu@redhat.com Thiago Jung Bauermann" 
        <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v13 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
Message-ID: <20180829002759.GG12252@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Young <dyoung@redhat.com>, Pingfan Liu <piliu@redhat.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        catalin marinas <catalin.marinas@arm.com>,
        will deacon <will.deacon@arm.com>, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com,
        heiko carstens <heiko.carstens@de.ibm.com>,
        ard biesheuvel <ard.biesheuvel@linaro.org>,
        james morse <james.morse@arm.com>, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "piliu@redhat.com Thiago Jung Bauermann" <bauerman@linux.vnet.ibm.com>
References: <20180801075820.3753-1-takahiro.akashi@linaro.org>
 <20180801075820.3753-4-takahiro.akashi@linaro.org>
 <20180801102951.527cfc57@ThinkPad>
 <20180802000150.GN11258@linaro.org>
 <20180806055047.GC4246@dhcp-128-65.nay.redhat.com>
 <20180809033416.GA5069@dhcp-128-65.nay.redhat.com>
 <1235507889.17337085.1533788045597.JavaMail.zimbra@redhat.com>
 <20180828052107.GE12252@linaro.org>
 <20180828134347.GB12178@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828134347.GB12178@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 09:43:47PM +0800, Dave Young wrote:
> Hi AKASHI,
> On 08/28/18 at 02:21pm, AKASHI Takahiro wrote:
> > Hi Dave,
> > 
> > On Thu, Aug 09, 2018 at 12:14:05AM -0400, Pingfan Liu wrote:
> > > 
> > > 
> > > 
> > > 
> > > ----- Original Message -----
> > > > From: "Dave Young" <dyoung@redhat.com>
> > > > To: "AKASHI Takahiro" <takahiro.akashi@linaro.org>, "Philipp Rudo" <prudo@linux.ibm.com>, "catalin marinas"
> > > > <catalin.marinas@arm.com>, "will deacon" <will.deacon@arm.com>, dhowells@redhat.com, vgoyal@redhat.com,
> > > > herbert@gondor.apana.org.au, davem@davemloft.net, bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com, "heiko
> > > > carstens" <heiko.carstens@de.ibm.com>, "ard biesheuvel" <ard.biesheuvel@linaro.org>, "james morse"
> > > > <james.morse@arm.com>, bhsharma@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
> > > > linux-kernel@vger.kernel.org, "piliu@redhat.com Thiago Jung Bauermann" <bauerman@linux.vnet.ibm.com>
> > > > Sent: Thursday, August 9, 2018 11:34:16 AM
> > > > Subject: Re: [PATCH v13 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
> > > > 
> > > > Add more cc. Pingfan Liu confirmed ppc does not use 0 as valid address,
> > > > if so it should be safe.
> > > > 
> > > > Pingfan, can you add more words?
> > > > 
> > > 
> > > ppc64 uses a few KB starting from 0 for exception handler.
> > 
> > It assures that 0 (zero) is valid, but won't be assigned as a result of
> > kexec_add_buffer().
> > 
> > So do you think that yet I should submit another patch set, introducing
> > explicit KEXEC_BUF_MEM_UNKNOWN, while assuming 0 by default is safe for now?
> > 
> > Now that this is the only comment against my v13, it's up to you.
> 
> I'm fine with your proposal.  It is simple enough, and we can look into
> it when it becomes a problem in the future which is unlikely.

Ok, thank you for this confirmation.

-Takahiro AKASHI

> Thanks
> Dave
