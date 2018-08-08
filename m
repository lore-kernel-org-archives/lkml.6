Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A7BC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC3821A27
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1oqP8O7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC3821A27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbeHHTCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbeHHTCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:02:49 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 257B821A27;
        Wed,  8 Aug 2018 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533746538;
        bh=c3q2FSvGKu4g5Uol5UXopV+sJDtVIPfHGqwZxEjnWAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D1oqP8O7QZOHLeqODZ/P5FDxeh7otbq8JBuSH4VrgB/DaI0PZwxISmp99hw46A9tc
         QiT6kvuHDKFLfylBMeMwYvR9XflpCxTFixeOBNE1HI7mNWCAjiHJe+SvwPqggKq1SV
         3oX+fmtx/SfZOj/isZnCbRvhX8eHtFnmKo8dGC3I=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id B6BC3140A1C; Wed,  8 Aug 2018 13:42:14 -0300 (-03)
Date:   Wed, 8 Aug 2018 13:42:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH 2/3] perf report: Add raw report support for s390
 auxiliary trace
Message-ID: <20180808164214.GE9543@kernel.org>
References: <20180802074622.13641-1-tmricht@linux.ibm.com>
 <20180802074622.13641-3-tmricht@linux.ibm.com>
 <87r2j9bkax.fsf@concordia.ellerman.id.au>
 <eda2632e-7919-5ffd-5f68-821e77d216fa@linux.ibm.com>
 <20180808155328.GA9543@kernel.org>
 <20180808155921.GB9543@kernel.org>
 <20180808160843.GC9543@kernel.org>
 <20180808161451.GD9543@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808161451.GD9543@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 08, 2018 at 01:14:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Aug 08, 2018 at 01:08:43PM -0300, Arnaldo Carvalho de Melo escreveu:
> > No need for __packed.
>  
> > I'm removing that to avoid having this failling in compilers that have
> > such a warning, since we default to Werror.
>  
> > Holler if there is something I'missing :-)
> 
> In file included from util/cpumap.h:10,
>                  from util/s390-cpumsf.c:150:
> util/s390-cpumsf.c: In function 's390_cpumsf_diag_show':
> util/s390-cpumsf.c:208:10: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>    pr_err("Invalid AUX trace diagnostic entry [%#08lx]\n", pos);
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /git/linux/tools/perf/util/debug.h:20:21: note: in definition of macro 'pr_fmt'
>  #define pr_fmt(fmt) fmt
>                      ^~~
> util/s390-cpumsf.c:208:3: note: in expansion of macro 'pr_err'
>    pr_err("Invalid AUX trace diagnostic entry [%#08lx]\n", pos);
>    ^~~~~~
> util/s390-cpumsf.c: In function 's390_cpumsf_trailer_show':
> util/s390-cpumsf.c:233:10: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>    pr_err("Invalid AUX trace trailer entry [%#08lx]\n", pos);

So for those I applied this, seems to pass the ones that were failing,
restarting tests...

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 2bcb160a08f0..d2c78ffd9fee 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -187,7 +187,7 @@ static bool s390_cpumsf_basic_show(const char *color, size_t pos,
 		pr_err("Invalid AUX trace basic entry [%#08zx]\n", pos);
 		return false;
 	}
-	color_fprintf(stdout, color, "    [%#08x] Basic   Def:%04x Inst:%#04x"
+	color_fprintf(stdout, color, "    [%#08zx] Basic   Def:%04x Inst:%#04x"
 		      " %c%c%c%c AS:%d ASN:%#04x IA:%#018llx\n"
 		      "\t\tCL:%d HPP:%#018llx GPP:%#018llx\n",
 		      pos, basic->def, basic->U,
@@ -205,10 +205,10 @@ static bool s390_cpumsf_diag_show(const char *color, size_t pos,
 				  struct hws_diag_entry *diag)
 {
 	if (diag->def < S390_CPUMSF_DIAG_DEF_FIRST) {
-		pr_err("Invalid AUX trace diagnostic entry [%#08lx]\n", pos);
+		pr_err("Invalid AUX trace diagnostic entry [%#08zx]\n", pos);
 		return false;
 	}
-	color_fprintf(stdout, color, "    [%#08x] Diag    Def:%04x %c\n",
+	color_fprintf(stdout, color, "    [%#08zx] Diag    Def:%04x %c\n",
 		      pos, diag->def, diag->I ? 'I' : ' ');
 	return true;
 }
@@ -230,10 +230,10 @@ static bool s390_cpumsf_trailer_show(const char *color, size_t pos,
 				     struct hws_trailer_entry *te)
 {
 	if (te->bsdes != sizeof(struct hws_basic_entry)) {
-		pr_err("Invalid AUX trace trailer entry [%#08lx]\n", pos);
+		pr_err("Invalid AUX trace trailer entry [%#08zx]\n", pos);
 		return false;
 	}
-	color_fprintf(stdout, color, "    [%#08x] Trailer %c%c%c bsdes:%d"
+	color_fprintf(stdout, color, "    [%#08zx] Trailer %c%c%c bsdes:%d"
 		      " dsdes:%d Overflow:%lld Time:%#llx\n"
 		      "\t\tC:%d TOD:%#lx 1:%#llx 2:%#llx\n",
 		      pos,
@@ -418,7 +418,7 @@ static bool s390_cpumsf_make_event(size_t pos,
 	event.sample.header.misc = sample.cpumode;
 	event.sample.header.size = sizeof(struct perf_event_header);
 
-	pr_debug4("%s pos:%#zx ip:%#lx P:%d CL:%d pid:%d.%d cpumode:%d cpu:%d\n",
+	pr_debug4("%s pos:%#zx ip:%#" PRIx64 " P:%d CL:%d pid:%d.%d cpumode:%d cpu:%d\n",
 		 __func__, pos, sample.ip, basic->P, basic->CL, sample.pid,
 		 sample.tid, sample.cpumode, sample.cpu);
 	if (perf_session__deliver_synth_event(sfq->sf->session, &event,
@@ -498,7 +498,7 @@ static int s390_cpumsf_samples(struct s390_cpumsf_queue *sfq, u64 *ts)
 	 */
 	aux_ts = get_trailer_time(buf);
 	if (!aux_ts) {
-		pr_err("[%#08lx] Invalid AUX trailer entry TOD clock base\n",
+		pr_err("[%#08" PRIx64 "] Invalid AUX trailer entry TOD clock base\n",
 		       sfq->buffer->data_offset);
 		aux_ts = ~0ULL;
 		goto out;
@@ -607,7 +607,7 @@ static int s390_cpumsf_run_decoder(struct s390_cpumsf_queue *sfq,
 		buffer->use_size = buffer->size;
 		buffer->use_data = buffer->data;
 	}
-	pr_debug4("%s queue_nr:%d buffer:%ld offset:%#lx size:%#zx rest:%#zx\n",
+	pr_debug4("%s queue_nr:%d buffer:%" PRId64 " offset:%#" PRIx64 " size:%#zx rest:%#zx\n",
 		  __func__, sfq->queue_nr, buffer->buffer_nr, buffer->offset,
 		  buffer->size, buffer->use_size);
 	err = s390_cpumsf_samples(sfq, ts);
