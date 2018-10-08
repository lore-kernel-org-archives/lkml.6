Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E478C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFF32087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="amLbsXxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEFF32087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbeJIB6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbeJIB6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:58:09 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23FFA2064A;
        Mon,  8 Oct 2018 18:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024303;
        bh=cMHaAZtVQXtWJbS8jBZpsevcQGkOp9TkWkPqtkIGgpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=amLbsXxVxFbhi6SQ6mYfy/LnXyjyxPEARX9YIRb7ndC2KqjY8xGemLVYbQltohPDw
         AjrNSEqDvlxb4vqFj8/Uw6VEsLQH9lP5RUWBggp9XQPoPXZZEvige4zACtZUJeWb/Z
         EeNM3owcBVwK5HZ4JFzsDZZFwlbpKQI4Xb3Kk+Jw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 4.14 91/94] tools: hv: fcopy: set error in case an unknown operation was requested
Date:   Mon,  8 Oct 2018 20:32:12 +0200
Message-Id: <20181008175610.889657954@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Kuznetsov <vkuznets@redhat.com>

commit c2d68afba86d1ff01e7300c68bc16a9234dcd8e9 upstream.

'error' variable is left uninitialized in case we see an unknown operation.
As we don't immediately return and proceed to pwrite() we need to set it
to something, HV_E_FAIL sounds good enough.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/hv/hv_fcopy_daemon.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/hv/hv_fcopy_daemon.c
+++ b/tools/hv/hv_fcopy_daemon.c
@@ -233,6 +233,7 @@ int main(int argc, char *argv[])
 			break;
 
 		default:
+			error = HV_E_FAIL;
 			syslog(LOG_ERR, "Unknown operation: %d",
 				buffer.hdr.operation);
 


