Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F79C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2900D2084A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPoYtHMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2900D2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933021AbeGCPqQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:46:16 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36764 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932392AbeGCPqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:46:14 -0400
Received: by mail-yb0-f196.google.com with SMTP id s1-v6so904709ybk.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I/G42nPSJRnpYxG+U45Df9SdiAdAUPbxvjgm/H5PM70=;
        b=HPoYtHMJLsqBLq1Vd7eU5naEsIQgvVLJz4rDFa3pHO7i54DfXuYMVQL9P2lWucL6Df
         Ja8XCRZ3LSCDC2Rjj+kt1blIpVPnDKVAwykX5D+vb1H+j/2piULgHZStzGqh+ke8GJr1
         PPdMF4531GLAWQ0cTxCI8t1+bBMPlOVmnXdnDuw0txdumJFVDm09SmcQpjzVjRagL3Mz
         1BHWhEV4IJe4gwR8uIE5COODa7Dsz8cdrKaX3qwfmpchsjLVlWBcHMF2X5V05q4kdEoX
         sWM234Aw+43Ih8kTDor6t1v/YExo2U8SmQHFV4tTDwUZZJhrj4dFjg52c7iHhWGW4AnR
         qXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=I/G42nPSJRnpYxG+U45Df9SdiAdAUPbxvjgm/H5PM70=;
        b=EfWXWi8MYV20LUUWKAP8owGv4IJrABgyR264uUezp4WTp67Eb3ORAmMsL4WLUlIiCM
         3XsCn12/25RCPyeptCQY1ddU/+maYMPr09JY7StIm+g/EsF3CFc3LxAOVi3HUczcdEJ4
         sazAR8nyeJllZN5vLAvqEsbrLTTHSM0YVrlwk0Jyt5fmf5uI6uPAIg25+12oim1+2q05
         9z++CbtvzvfnNy3WnNEeJ5Ph20vqEtiJP8FTyePOCL+ZxX185canarmpCg47m8EX+sfS
         dInk8VWhseWLYLcExZl+fcfKjwCgp1FMQkpkMUcKfrZaK2/bHLIj5aS+sdDP3hCdGz+P
         Y5/Q==
X-Gm-Message-State: APt69E0djahUu3J1NObaZVc5KOROagTKefqhMezcp0xOMlZFw4oJiAr6
        626WBjps3ayZ0Tt3hix+tpjcjyZ6
X-Google-Smtp-Source: ADUXVKLRwzRrri+THUp0HB6x4j8ydMcbEYR6pmQh4dZdwPq29m3MpvDnDuSYsh+AwGzm8D1BnrOeUQ==
X-Received: by 2002:a25:63d6:: with SMTP id x205-v6mr15180744ybb.248.1530632773171;
        Tue, 03 Jul 2018 08:46:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:a4be])
        by smtp.gmail.com with ESMTPSA id u4-v6sm460141ywd.21.2018.07.03.08.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 08:46:12 -0700 (PDT)
Date:   Tue, 3 Jul 2018 08:46:10 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
Message-ID: <20180703154610.GR533219@devbig577.frc2.facebook.com>
References: <36fb9c9f873629abb7bf3758033cce00e463f768.camel@kernel.crashing.org>
 <CA+55aFzUhe7j+6XL_BB+gvSnCvMCOePZhanTBk5tq=zqvFFWSw@mail.gmail.com>
 <d56f1c255f7caa913ad77a174e1e3bde08043ac0.camel@kernel.crashing.org>
 <0dc3c0632b1821bd07abdf0224ccd9f32a4f250d.camel@kernel.crashing.org>
 <CA+55aFyzYXSTTuVoGfVeC574-7i0zp3q39RTsiPn3GoRceuwAQ@mail.gmail.com>
 <213dd8fa77629e04277e68552068581da881e7e4.camel@kernel.crashing.org>
 <CA+55aFy927VYjFDwe9Zy_M+XFNxSFh2HLFcQ25pm8AMNXBUoQA@mail.gmail.com>
 <CA+55aFx7wgjx+d0Vdtpgzc46HM-4vN2r-Hyf2ZC4gQU-nxopMQ@mail.gmail.com>
 <1303e511c44f639c562a02ae28aa530144277c99.camel@kernel.crashing.org>
 <b15584ccdfcb3bf6d42665635aaa9150ed3244ba.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b15584ccdfcb3bf6d42665635aaa9150ed3244ba.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jul 03, 2018 at 03:22:47PM +1000, Benjamin Herrenschmidt wrote:
> +bool kernfs_has_children(struct kernfs_node *kn)
> +{
> +	bool has_children = false;
> +	struct kernfs_node *pos;
> +
> +	/* Lockless shortcut */
> +	if (RB_EMPTY_NODE(&kn->rb))
> +		return false;

Hmm... shouldn't it be testing !rb_first(kn->dir.children)?  The above
would test whether @kn itself is unlinked.

> +
> +	/* Now check for active children */
> +	mutex_lock(&kernfs_mutex);
> +	pos = NULL;
> +	while ((pos = kernfs_next_descendant_post(pos, kn)) && pos != kn) {
> +		if (kernfs_active(pos)) {
> +			has_children = true;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&kernfs_mutex);
> +
> +	return has_children;

The active ref is there to synchronize removal against in-flight reads
so that kernfs_remove() can wait for them to drain.  On return from
kernfs_remove(), the node is guaranteed to be off the rbtree and the
above test isn't necessary.  !rb_first() test should be enough
(provided that there's external synchronization, of course).

Thanks.

-- 
tejun
