Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E59C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F8920661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UniB8Z0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F8920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeLIWIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:08:46 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32796 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLIWIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:08:43 -0500
Received: by mail-ed1-f68.google.com with SMTP id p6so7936979eds.0;
        Sun, 09 Dec 2018 14:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hbSvHtlnnICkiQ5tzxO9HPJjPeorQQ/8l5LjmlzxqsQ=;
        b=UniB8Z0GIOeTb720bZbh9kmcNOApIIP8OPE8EHMn9foW66dhEWdPMOQB5WPA9mNgqg
         tW7UGmxfvBSfN3E88r9cdU/RZyO1XMUjhekvydS3M7gt7UrUR8d8oygMjmFBJzMOD9TC
         nEfEOyFvDNXUS7mQWC6zf9md4/Y5lb2L1CNHgWAz9fAm0fLA+x3jfHkWUuYzEGV4mwEP
         Hv7OfmYqBKlaQQfxkbT7/jS2S7PAlvSC82e4SsRezdHE97fY9Id9H5OUTp8l4oN241bg
         lCs6KPHN1OBNFvDReqpI+yIxbYwb7XR/DJwfsD38ju0I+k2O6CwEZqkkmfRf3eLliFyL
         ER1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hbSvHtlnnICkiQ5tzxO9HPJjPeorQQ/8l5LjmlzxqsQ=;
        b=YtH43diR6f4R6QiahT+CrNKJM0z7+cArIIP485DolX3BFibGFWlfYz1M8rkfrTS//k
         GDH/tuhc1XNspGpZo4TEhhGj1czauR4E9YanXbSQUnoDMt+75rfXblzJKNIn6dw4vJEJ
         coxCC+LRnYxzn+ecFYjIDewUoAxR7M58t8sIbxirAiI7S9ZxQCVzJVYJuZrPNu30B8hN
         POeg08O04x7OTFtwzi0t0EnCFrtwJku/KZveBHEM6FmIEDa29p35OdJhGtgl8VD55hzE
         IMi7DyGWQC2JxJzJXreybiyiuKdFHV0CDZlTMsa8v7vN/fhibpKNxwkIy7ZVhAP3t5wf
         tWCQ==
X-Gm-Message-State: AA+aEWZDGKml7myLYImXuqdOaFKPdFITbeSxo9vWHfLdjbnzCSFvETFo
        RJBa3FNjjGvQqg0hWhH6XjA=
X-Google-Smtp-Source: AFSGD/ViLQFhSlBJQwi1DSM1Oeyo7KRMNyGOTNhiyRTAZ7VtYpNknyo44HhXRPJp3KPL3D3ZmAFSdg==
X-Received: by 2002:a50:d6c5:: with SMTP id l5mr9443699edj.145.1544393321437;
        Sun, 09 Dec 2018 14:08:41 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40bc:4d00:e8b1:47b5:cae1:da95])
        by smtp.gmail.com with ESMTPSA id n16-v6sm1512966eja.6.2018.12.09.14.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 14:08:40 -0800 (PST)
Date:   Sun, 9 Dec 2018 23:08:40 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Tycho Andersen <tycho@tycho.ws>, linux-sparse@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1] copy_{to,from}_user(): only inline when !__CHECKER__
Message-ID: <20181209220839.sf5t3mis4pawqthc@ltop.local>
References: <20181209204449.18906-1-tycho@tycho.ws>
 <20181209210220.GB2217@ZenIV.linux.org.uk>
 <20181209212523.GE30796@cisco>
 <20181209213951.kumz33u6prb2seqz@ltop.local>
 <20181209215651.GD2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209215651.GD2217@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 09:56:51PM +0000, Al Viro wrote:
> On Sun, Dec 09, 2018 at 10:39:52PM +0100, Luc Van Oostenryck wrote:
> 
> > There are several more or less bad/good solutions, like:
> > * add raw_copy_{to,from}_user() in the list of checked function
> >   (not inlined in most archs).
> > * add a new annotation to force sparse to check the byte count
> >   (I'm thinking about __range__/OP_RANGE or something similar).
> > * do these checks before functions are inlined (but then some
> >   constant count could not yet be seen as constant).
>   * just spell it out in copy_to_user() itself - as in
> #ifdef C_T_U_SIZE_LIMIT
> 	if (__builtin_constant_p(count) && count > C_T_U_SIZE_LIMIT)
> 		/* something warning-triggering */
> #endif
> in the beginning of copy_from_user().  Or simply
> #ifdef C_T_U_SIZE_LIMIT
> 	BUILD_BUG_ON(__builtin_constant_p(count) && count > C_T_U_SIZE_LIMIT);
> #endif
> in there...

Yes, I agree.

-- Luc
