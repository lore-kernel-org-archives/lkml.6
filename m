Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738C1C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FC7204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FC7204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731681AbeIMTIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:08:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34774 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbeIMTIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:08:42 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 127F5D15;
        Thu, 13 Sep 2018 13:59:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 119/197] cfq: Suppress compiler warnings about comparisons
Date:   Thu, 13 Sep 2018 15:31:08 +0200
Message-Id: <20180913131846.308563276@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

[ Upstream commit f7ecb1b109da1006a08d5675debe60990e824432 ]

This patch does not change any functionality but avoids that gcc
reports the following warnings when building with W=1:

block/cfq-iosched.c: In function ?cfq_back_seek_max_store?:
block/cfq-iosched.c:4741:13: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
  if (__data < (MIN))      \
             ^
block/cfq-iosched.c:4756:1: note: in expansion of macro ?STORE_FUNCTION?
 STORE_FUNCTION(cfq_back_seek_max_store, &cfqd->cfq_back_max, 0, UINT_MAX, 0);
 ^~~~~~~~~~~~~~
block/cfq-iosched.c: In function ?cfq_slice_idle_store?:
block/cfq-iosched.c:4741:13: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
  if (__data < (MIN))      \
             ^
block/cfq-iosched.c:4759:1: note: in expansion of macro ?STORE_FUNCTION?
 STORE_FUNCTION(cfq_slice_idle_store, &cfqd->cfq_slice_idle, 0, UINT_MAX, 1);
 ^~~~~~~~~~~~~~
block/cfq-iosched.c: In function ?cfq_group_idle_store?:
block/cfq-iosched.c:4741:13: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
  if (__data < (MIN))      \
             ^
block/cfq-iosched.c:4760:1: note: in expansion of macro ?STORE_FUNCTION?
 STORE_FUNCTION(cfq_group_idle_store, &cfqd->cfq_group_idle, 0, UINT_MAX, 1);
 ^~~~~~~~~~~~~~
block/cfq-iosched.c: In function ?cfq_low_latency_store?:
block/cfq-iosched.c:4741:13: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
  if (__data < (MIN))      \
             ^
block/cfq-iosched.c:4765:1: note: in expansion of macro ?STORE_FUNCTION?
 STORE_FUNCTION(cfq_low_latency_store, &cfqd->cfq_latency, 0, 1, 0);
 ^~~~~~~~~~~~~~
block/cfq-iosched.c: In function ?cfq_slice_idle_us_store?:
block/cfq-iosched.c:4775:13: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
  if (__data < (MIN))      \
             ^
block/cfq-iosched.c:4782:1: note: in expansion of macro ?USEC_STORE_FUNCTION?
 USEC_STORE_FUNCTION(cfq_slice_idle_us_store, &cfqd->cfq_slice_idle, 0, UINT_MAX);
 ^~~~~~~~~~~~~~~~~~~
block/cfq-iosched.c: In function ?cfq_group_idle_us_store?:
block/cfq-iosched.c:4775:13: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
  if (__data < (MIN))      \
             ^
block/cfq-iosched.c:4783:1: note: in expansion of macro ?USEC_STORE_FUNCTION?
 USEC_STORE_FUNCTION(cfq_group_idle_us_store, &cfqd->cfq_group_idle, 0, UINT_MAX);
 ^~~~~~~~~~~~~~~~~~~

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/cfq-iosched.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -4735,12 +4735,13 @@ USEC_SHOW_FUNCTION(cfq_target_latency_us
 static ssize_t __FUNC(struct elevator_queue *e, const char *page, size_t count)	\
 {									\
 	struct cfq_data *cfqd = e->elevator_data;			\
-	unsigned int __data;						\
+	unsigned int __data, __min = (MIN), __max = (MAX);		\
+									\
 	cfq_var_store(&__data, (page));					\
-	if (__data < (MIN))						\
-		__data = (MIN);						\
-	else if (__data > (MAX))					\
-		__data = (MAX);						\
+	if (__data < __min)						\
+		__data = __min;						\
+	else if (__data > __max)					\
+		__data = __max;						\
 	if (__CONV)							\
 		*(__PTR) = (u64)__data * NSEC_PER_MSEC;			\
 	else								\
@@ -4769,12 +4770,13 @@ STORE_FUNCTION(cfq_target_latency_store,
 static ssize_t __FUNC(struct elevator_queue *e, const char *page, size_t count)	\
 {									\
 	struct cfq_data *cfqd = e->elevator_data;			\
-	unsigned int __data;						\
+	unsigned int __data, __min = (MIN), __max = (MAX);		\
+									\
 	cfq_var_store(&__data, (page));					\
-	if (__data < (MIN))						\
-		__data = (MIN);						\
-	else if (__data > (MAX))					\
-		__data = (MAX);						\
+	if (__data < __min)						\
+		__data = __min;						\
+	else if (__data > __max)					\
+		__data = __max;						\
 	*(__PTR) = (u64)__data * NSEC_PER_USEC;				\
 	return count;							\
 }


