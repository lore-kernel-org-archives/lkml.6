Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D017C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA6321871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JTblI9xX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfADAmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 19:42:36 -0500
Received: from mail-io1-f73.google.com ([209.85.166.73]:39498 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbfADAmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 19:42:36 -0500
Received: by mail-io1-f73.google.com with SMTP id q23so40155150ior.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 16:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UhcxMxiwBOiKaw8gDgE2cvjkyx4EHhVXjk74arqb5fk=;
        b=JTblI9xXkog2U8oOQ4flQbXi8Vv4XJ/X0+GOODMJfpn+SpyOSjsS/sxp24kRKgqU+q
         zS3xfS9+2wfq6c9MEEDV6psZBLRWGjy8rR+QUJ3HUd4IzIJA/59m37EuRD55dRdvGaqn
         B11fpwIJcU7wr7Tpw0qes3Gj1UJK7Nwjff3fri5eMhkbhkkUU2qLAI0O24BdUqm/JVmJ
         NGFmvoTWW8hhBK9HQC0F/LHUrpD65J0lCmcW8dqH/SoWIXpd9xKHYILcv02SWNadoOqw
         tfBSfh0Dweh4MO5tp8F68MI7CMpcm1Amv83DruKQ7bbBTduR1+Pds4lQhjKGpB2hwrMV
         nzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UhcxMxiwBOiKaw8gDgE2cvjkyx4EHhVXjk74arqb5fk=;
        b=lHSEOK3I2yxP7rhFz1bj0Q6MfU0c/bmnbjOEDNozcEqOFwtORO/0g09aQ7APnzcDGc
         fkcGr+3Rw+xG5R+Zb7Bx+DiHI9kKeovxLKUZAGMF8TufGT0V0SxrjzERsfOZ0iGB7dO3
         5etRD43gM9sjsjgMgxirzOdd+fbFHNLic+zrvxCrnX1wbNvQVlTt/2k6ZW+7lh2y//e3
         j1VsBPS3cQLoZABzMYnevHbCOF7lhMh9ibwtZxsQaiv60jADoqk9m86XLpvF/lVJQLXT
         lyIBjgWdlA1ma5qgntKHjT5UjZD6+QUsdFryu9rvzG5kZLt1ESFbimJymG2hrufnjMIp
         E7bg==
X-Gm-Message-State: AA+aEWZrdJF8UyeqhKSO0P8QpA8Ls7eTe0uxy4JevirPVot/7yl54Rjp
        pdj3BbStc+wRd2ubgfzd7e7v0NcQkQgVdxk=
X-Google-Smtp-Source: ALg8bN7jGg47f5Day30h3jmyv/QDNpMAbEb5/Fvy0REkEzC4kLiFuF4JodwQf/P/dWU2AJKfpb+PQvvORGnb0MA=
X-Received: by 2002:a24:760e:: with SMTP id z14mr36502756itb.5.1546562554900;
 Thu, 03 Jan 2019 16:42:34 -0800 (PST)
Date:   Thu,  3 Jan 2019 16:42:03 -0800
Message-Id: <20190104004203.116155-1-jsperbeck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
Subject: [PATCH] i2c: core-smbus: don't trace smbus_reply data on errors
From:   John Sperbeck <jsperbeck@google.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, John Sperbeck <jsperbeck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an smbus transfer fails, there's no guarantee that the output
buffer was written.  So, avoid copying from the output buffer when
tracing after an error.  This was 'mostly harmless', but would trip
up kasan checking if left-over cruft in byte 0 is a large length,
causing us to read from unwritten memory.

Signed-off-by: John Sperbeck <jsperbeck@google.com>
---
 drivers/i2c/i2c-core-smbus.c |  2 +-
 include/trace/events/smbus.h | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 9cd66cabb84f..132119112596 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -585,7 +585,7 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 trace:
 	/* If enabled, the reply tracepoint is conditional on read_write. */
 	trace_smbus_reply(adapter, addr, flags, read_write,
-			  command, protocol, data);
+			  command, protocol, data, res);
 	trace_smbus_result(adapter, addr, flags, read_write,
 			   command, protocol, res);
 
diff --git a/include/trace/events/smbus.h b/include/trace/events/smbus.h
index d2fb6e1d3e10..b6376a7c7e74 100644
--- a/include/trace/events/smbus.h
+++ b/include/trace/events/smbus.h
@@ -138,8 +138,8 @@ TRACE_EVENT_CONDITION(smbus_reply,
 	TP_PROTO(const struct i2c_adapter *adap,
 		 u16 addr, unsigned short flags,
 		 char read_write, u8 command, int protocol,
-		 const union i2c_smbus_data *data),
-	TP_ARGS(adap, addr, flags, read_write, command, protocol, data),
+		 const union i2c_smbus_data *data, int res),
+	TP_ARGS(adap, addr, flags, read_write, command, protocol, data, res),
 	TP_CONDITION(read_write == I2C_SMBUS_READ),
 	TP_STRUCT__entry(
 		__field(int,	adapter_nr		)
@@ -159,16 +159,16 @@ TRACE_EVENT_CONDITION(smbus_reply,
 		switch (protocol) {
 		case I2C_SMBUS_BYTE:
 		case I2C_SMBUS_BYTE_DATA:
-			__entry->len = 1;
+			__entry->len = res < 0 ? 0 : 1;
 			goto copy;
 		case I2C_SMBUS_WORD_DATA:
 		case I2C_SMBUS_PROC_CALL:
-			__entry->len = 2;
+			__entry->len = res < 0 ? 0 : 2;
 			goto copy;
 		case I2C_SMBUS_BLOCK_DATA:
 		case I2C_SMBUS_BLOCK_PROC_CALL:
 		case I2C_SMBUS_I2C_BLOCK_DATA:
-			__entry->len = data->block[0] + 1;
+			__entry->len = res < 0 ? 0 : data->block[0] + 1;
 		copy:
 			memcpy(__entry->buf, data->block, __entry->len);
 			break;
-- 
2.20.1.415.g653613c723-goog

