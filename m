Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D446C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42BE20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="QiL8Kc/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42BE20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeLFXR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:17:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44088 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeLFXR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:17:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so913372pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 15:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7PMWavZbLNzKGrSvcCIxdUykqi3Rc8HSIZluMpdm7ig=;
        b=QiL8Kc/s4ryVBg/laEHpgX4Y5pSROL1RhPmujbfG0gsXSSzduG9+4oM2gIPmwbg+Lt
         V4xutEe7J88+mD6wurQqGkXKYOwwzzXeRBaCW6m+t7+p8wA3C/EVAqzP61tiSs7RLPlE
         1qnNu0MhiABJpRaa7WWKWAtmrT3cy2GJghDMOFhUiIOoQF9IrS21It16vFDSbCC4Wnt5
         qqyKhYrXs4otukqna6wPd4shlT7x1wE6Z3NJBT0oXzY9n2tzLmmLFDx1NZEFepbaICWg
         SzWT3jMcp1bU6xGXexO5gmIOVjo8Q4GZaUpXSgoHppKD+a5ZquK2bLmsW42RowwLiICg
         tTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7PMWavZbLNzKGrSvcCIxdUykqi3Rc8HSIZluMpdm7ig=;
        b=XJaMyqvXl+tfgyzH2CbV3ZWJJjtWbKQWzqg/5qoVZRH26npRZ4oiFOMYtmxBY9+jm9
         1zlCR/cgoi1HrpMiFd/gRePDlNIcAk9sNAppDnGOs+7GgStIl5YQg4RUpV9pmNCIne4J
         nhyqGh8M/i8ONezfIiGcaVW3XPC2rbNerL3Khc71h9aVGn25vN1Z03df776ivM4Iq+It
         ev+KkecSjpvl3NJH+QaiVMcVAcvs1JN7xnfDKpeEG8Gt+8My+lh35rOZ04yo0/3sGpNu
         BUqDEoNDE4kMykaEwR+TfULmO2zjGwi0MR0FSxSGk5wuFuVGJhOKxorn1YkkX2xFnZKp
         CKVw==
X-Gm-Message-State: AA+aEWZUQRuThRZFqge+WAuEMBPH48qVgDkfNuN72vogdOEfbBjQ5hEu
        l37V6ozdqUgpbdQTY3QnKiIHPw==
X-Google-Smtp-Source: AFSGD/VdEgu/6mmIHPmxwI6i3Wrs8Tru3jy2BYn/XOmH6SFeSM1phw1Atj1ySzxTPrE7IumCTWhwsA==
X-Received: by 2002:a62:68c5:: with SMTP id d188mr31585464pfc.194.1544138275526;
        Thu, 06 Dec 2018 15:17:55 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:b824:a031:b50e:f401])
        by smtp.gmail.com with ESMTPSA id s4sm1353483pgp.13.2018.12.06.15.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 15:17:54 -0800 (PST)
Date:   Fri, 7 Dec 2018 00:17:45 +0100
From:   Christian Brauner <christian@brauner.io>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, serge@hallyn.com, jannh@google.com,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        dancol@google.com, timmurray@google.com, linux-man@vger.kernel.org,
        keescook@chromium.org, fweimer@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
Message-ID: <20181206231742.xxi4ghn24z4h2qki@brauner.io>
References: <20181206121858.12215-1-christian@brauner.io>
 <87sgzahf7k.fsf@xmission.com>
 <D372C766-572C-4897-8F02-2FD0E72CCFAC@brauner.io>
 <875zw6bh2z.fsf@xmission.com>
 <20181206193017.wpxls5p3zgjd6rv2@brauner.io>
 <871s6u9z6u.fsf@xmission.com>
 <20181206213152.gvci7ijr3dokew7w@brauner.io>
 <87o99y72gi.fsf@xmission.com>
 <20181206223948.gyfdtkgbhtozmpsp@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181206223948.gyfdtkgbhtozmpsp@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 11:39:48PM +0100, Christian Brauner wrote:
> On Thu, Dec 06, 2018 at 03:46:53PM -0600, Eric W. Biederman wrote:
> > Christian Brauner <christian@brauner.io> writes:
> > 
> > >> Your intention is to add the thread case to support pthreads once the
> > >> process case is sorted out.  So this is something that needs to be made
> > >> clear.  Did I miss how you plan to handle threads?
> > >
> > > Yeah, maybe you missed it in the commit message [2] which is based on a
> > > discussion with Andy [3] and Arnd [4]:
> > 
> > Looking at your references I haven't missed it.  You are not deciding
> > anything as of yet to keep it simple.  Except you are returning
> > EOPNOTSUPP.  You are very much intending to do something.
> 
> That was clear all along and was pointed at every occassion in the
> threads. I even went through the hazzle to give you all of the
> references when there's lore.kernel.org.
> 
> > 
> > Decide.  Do you use the flags parameter or is the width of the
> > target depending on the flags.

Ok, let's try to be constructive. I understand the general concern for
the future so let's put a contract into the commit message stating that
the width of the target aka *what is signaled* will be based on a flag
parameter if we ever extend it:

taskfd_send_signal(fd, SIGSTOP, NULL, TASKFD_PGID);
taskfd_send_signal(fd, SIGSTOP, NULL, TASKFD_TID);

with the current default being

taskfd_send_signal(fd, SIGSTOP, NULL, TASKFD_PID);

This seems to me the cleanest solution as we only use one type of file
descriptor. Can everyone be on board with this? If so I'm going to send
out a new version of the patch.

Christian
