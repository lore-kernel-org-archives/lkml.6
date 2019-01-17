Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA48C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D01320851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WcUYBF2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfAQMse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:48:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47144 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbfAQMse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f5w29PS1hdR7Z2K/DINYVO0LkjCbQMc/0yfsez3Z1rw=; b=WcUYBF2Mv7XPavSZ5QXwAmc3G
        9JMqpW60Io3XL3fm5Wfd4klGybXgwYjI15/7Eq42W96dJgQlNdllxYEzhwatA3I7IBC3ydm40aIHB
        sZByBk8fZFcrfJoIxQNSMALPqqMYRrWivCvsE4D4O9nnyea+vTY3+lF+WE9P/0SPBJRBFplBbNDjT
        oJD9K3e9HZhyKxhvDm/CJ3jxE+DNTov4+ZIU+ptQ4rNmSoyOBADULnKXhF1srqsqY2Pibzah8f3p2
        mjkF6BF1oCtCepCvyi/MxnFi71uag9EAPkK8kR2/jjTAujtQ+YDk2dVHtBwOQjgHtoAroy2tz4Blu
        2rqTwlbFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gk75v-0006uo-W3; Thu, 17 Jan 2019 12:48:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7322202647CE; Thu, 17 Jan 2019 13:48:24 +0100 (CET)
Date:   Thu, 17 Jan 2019 13:48:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        acme@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, dsahern@gmail.com
Subject: Re: [PATCH v10 perf, bpf-next 1/9] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Message-ID: <20190117124824.GE10486@hirez.programming.kicks-ass.net>
References: <20190116162931.1542429-1-songliubraving@fb.com>
 <20190116162931.1542429-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116162931.1542429-2-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 08:29:23AM -0800, Song Liu wrote:
> +/* callback function to generate ksymbol name */
> +typedef int (perf_ksymbol_get_name_f)(char *name, int name_len, void *data);
> +extern void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len,
> +			       bool unregister,
> +			       perf_ksymbol_get_name_f get_name, void *data);
> +

I'm not liking the getname thing.. I know that's what BPF does, but can
we please do that in the caller or something?


--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1114,11 +1114,8 @@ static inline void perf_event_task_sched
 
 extern void perf_event_mmap(struct vm_area_struct *vma);
 
-/* callback function to generate ksymbol name */
-typedef int (perf_ksymbol_get_name_f)(char *name, int name_len, void *data);
 extern void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len,
-			       bool unregister,
-			       perf_ksymbol_get_name_f get_name, void *data);
+			       bool unregister, const char *name);
 
 extern struct perf_guest_info_callbacks *perf_guest_cbs;
 extern int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
@@ -1341,11 +1338,8 @@ static inline int perf_unregister_guest_
 
 static inline void perf_event_mmap(struct vm_area_struct *vma)		{ }
 
-typedef int (perf_ksymbol_get_name_f)(char *name, int name_len, void *data);
 static inline void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len,
-				      bool unregister,
-				      perf_ksymbol_get_name_f get_name,
-				      void *data)			{ }
+				      bool unregister, const char *name) { }
 static inline void perf_event_exec(void)				{ }
 static inline void perf_event_comm(struct task_struct *tsk, bool exec)	{ }
 static inline void perf_event_namespaces(struct task_struct *tsk)	{ }
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7698,8 +7698,7 @@ static void perf_event_ksymbol_output(st
 	perf_output_end(&handle);
 }
 
-void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len, bool unregister,
-			perf_ksymbol_get_name_f get_name, void *data)
+void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len, bool unregister, const char *sym)
 {
 	struct perf_ksymbol_event ksymbol_event;
 	char name[KSYM_NAME_LEN];
@@ -7713,7 +7712,7 @@ void perf_event_ksymbol(u16 ksym_type, u
 	    ksym_type == PERF_RECORD_KSYMBOL_TYPE_UNKNOWN)
 		goto err;
 
-	get_name(name, KSYM_NAME_LEN, data);
+	strlcpy(name, sym, KSYM_NAME_LEN);
 	name_len = strlen(name) + 1;
 	while (!IS_ALIGNED(name_len, sizeof(u64)))
 		name[name_len++] = '\0';
