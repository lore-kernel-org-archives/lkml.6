Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBDDC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27372086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27372086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeIYSHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:07:34 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45593 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbeIYSHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:07:33 -0400
Received: by mail-qk1-f196.google.com with SMTP id q20-v6so8930384qkc.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 05:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0mkvli9SxU87U7/v9xrlIcAk2jawKRHDYgJeiFV41Y4=;
        b=EA8I0OLnm6YpRg+DXEfXi+Cu87kPpeCDjuN+85aB2Eno3IGJRRtHpUG80bmLLC7Z8T
         f82QRbxsqv4Fwox+LCsUirDZ7sqzBYw/3fTxzTK8GK+tEN3O5gCmosjLNBLh7/ZT0tIQ
         i8geBcpu8VUjtFeI4tCsLODW/0s15Q4X9oQ1mob52bTs587z93pj+LrZkYZ1YEY2IRb/
         FagEHwJxPlNauC86H84MkNTcmZsbHmWZ2cuXXG9/u10b0Qwg6bLSjt+0wwmhYBtkA9cz
         ScKQnjxlz+Xy48h2xUtr4wTEzTM0Qau4pT7tRLpjHhWbSmd2Usdns0Df32Njh9RLSe6L
         4g+A==
X-Gm-Message-State: ABuFfogFvIvaC83QWNDmv+6cRV0Bx9VEhSFtObJ9lzA2kPlSpga7+Sk2
        LXHD52v08SZIwDk5/hPKAx9r2WgLQOl/hVFhfdI=
X-Google-Smtp-Source: ACcGV61k6gZxmBCbWcZF1ZsipNGnWLzhdC5pJaY5sWmNb5d6drT86BoVKU2noAo14cLZqP6fo4mebUT/uCcdFmNAf1I=
X-Received: by 2002:a37:c542:: with SMTP id p63-v6mr432855qki.330.1537876820426;
 Tue, 25 Sep 2018 05:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180823024051.GC13343@shao2-debian> <20180823041434.GC3677@linux-r8p5>
 <20180824030920.GD3677@linux-r8p5>
In-Reply-To: <20180824030920.GD3677@linux-r8p5>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 25 Sep 2018 14:00:03 +0200
Message-ID: <CAK8P3a3TMUbqLtde-wJyvF+H31VTPQwCKCqPjf41dwGMK-vbQg@mail.gmail.com>
Subject: Re: [PATCH] ipc/shm: properly return EIDRM in shm_lock()
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     rong.a.chen@intel.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        dbueso@suse.de, manfred@colorfullife.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 5:09 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> When getting rid of the general ipc_lock(), this was missed
> furthermore, making the comment around the ipc object validity
> check bogus. Under EIDRM conditions, callers will in turn not
> see the error and continue with the operation.
>
> Fixes: 82061c57ce9 (ipc: drop ipc_lock())
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---

Oddly, this change introduces a gcc warning in some configurations
(i.e. with randstruct enabled):

ipc/shm.c: In function 'shm_lock':
ipc/shm.c:209:9: note: randstruct: casting between randomized
structure pointer types (ssa): 'struct shmid_kernel' and 'struct
kern_ipc_perm'
  return (void *)ipcp;
         ^~~~~~~~~~~~

Not sure why we didn't see that warning before, probably
it ended up making its own thing when the return code
was uninitialized.

The change below gets rid of the warning, but is a bit ugly.

       Arnd

diff --git a/ipc/shm.c b/ipc/shm.c
index fe3c42e66a48..922012a745e5 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -180,10 +180,12 @@ static inline struct shmid_kernel
*shm_obtain_object_check(struct ipc_namespace
 static inline struct shmid_kernel *shm_lock(struct ipc_namespace *ns, int id)
 {
        struct kern_ipc_perm *ipcp;
+       int ret;

        rcu_read_lock();
        ipcp = ipc_obtain_object_idr(&shm_ids(ns), id);
-       if (IS_ERR(ipcp))
+       ret = PTR_ERR_OR_ZERO(ipcp);
+       if (ret)
                goto err;

        ipc_lock_object(ipcp);
@@ -199,14 +201,14 @@ static inline struct shmid_kernel
*shm_lock(struct ipc_namespace *ns, int id)
        }

        ipc_unlock_object(ipcp);
-       ipcp = ERR_PTR(-EIDRM);
+       ret = -EIDRM;
 err:
        rcu_read_unlock();
        /*
         * Callers of shm_lock() must validate the status of the returned ipc
         * object pointer and error out as appropriate.
         */
-       return (void *)ipcp;
+       return ERR_PTR(ret);
 }

 static inline void shm_lock_by_ptr(struct shmid_kernel *ipcp)
