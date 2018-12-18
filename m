Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68108C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3714321873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151302;
	bh=PQ/tq4z2bkOkOCVX2oQ7F9exo1OfctrfmiERuYUt0c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A4xQkq6cta9YWAlE58wlCVmPoOqbhjjWmSl5WEhCP+JVL/jP6IkYFZ0wPJSPRKZLr
	 KVLziYzqTffhQ4hDNlC6ux5YMJKygiD9DeJQMdmVZ81rQkmyfl0k44qGk814UbRvbt
	 Z3cFMqkwPiOH960B1t43PY7dEsalTitMGHwsgo4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeLRQll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:41:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbeLRQli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:41:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C68321873;
        Tue, 18 Dec 2018 16:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151297;
        bh=PQ/tq4z2bkOkOCVX2oQ7F9exo1OfctrfmiERuYUt0c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sEG5rlnu8pDpwBKBYyuYMbNOFZnjHjMSMEnIRyHySo6ir+AwzRpYmg/OWo8DgjFPr
         zxuhk7sRtjTaO9OyYrtQo7LDOf5PQZbz3JLE9Nce0kf/kfQtN4tJo3lNgJdBHU9Bao
         xd6TfCvBSeSGe5t1eGwYe1bDGy89YpDvyG7WRvlY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Zanussi <tom.zanussi@linux.intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 27/44] tracing: Fix memory leak in create_filter()
Date:   Tue, 18 Dec 2018 17:39:39 +0100
Message-Id: <20181218163930.677328030@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit b61c19209c2c35ea2a2fe502d484703686eba98c upstream.

The create_filter() calls create_filter_start() which allocates a
"parse_error" descriptor, but fails to call create_filter_finish() that
frees it.

The op_stack and inverts in predicate_parse() were also not freed.

Found by kmemleak detector.

Cc: stable@vger.kernel.org
Fixes: 80765597bc587 ("tracing: Rewrite filter logic to be simpler and faster")
Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_events_filter.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -570,11 +570,13 @@ predicate_parse(const char *str, int nr_
 		}
 	}
 
+	kfree(op_stack);
+	kfree(inverts);
 	return prog;
 out_free:
 	kfree(op_stack);
-	kfree(prog_stack);
 	kfree(inverts);
+	kfree(prog_stack);
 	return ERR_PTR(ret);
 }
 
@@ -1718,6 +1720,7 @@ static int create_filter(struct trace_ev
 	err = process_preds(call, filter_string, *filterp, pe);
 	if (err && set_str)
 		append_filter_err(pe, *filterp);
+	create_filter_finish(pe);
 
 	return err;
 }


