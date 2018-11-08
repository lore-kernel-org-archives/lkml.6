Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AB3C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6606F2089A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6606F2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeKIJUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 04:20:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41242 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKIJUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 04:20:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so15475pgh.8;
        Thu, 08 Nov 2018 15:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RayUoQ5VgEvK0KzVm/z37jBLsiSxDTNmYtmh438jC8w=;
        b=OFjzKjmPe+FsqSPOcCIOrqt27CGrxDnaWlYSbTVmFMl9nc8DuRsAWek2jNBc9KLvvf
         /9T+zCg9yLZY5odFG7hqSfyXhqvnr74RQYgMkJe/lqb6XVgAq0wqTFUd1wCq4lccBF2P
         ZoJfwZfjnrsCYSQ4P6H4ivMT++oo4JvGiCp/vX1L8gJk/mBrE2QKpWSVjjefDRCQYpz3
         O8JhHRyKicHKGg4o4JhiLfmB76yODPtdheps+jRjq7yhbEkkHxype6vASYTuDn74z21/
         BGTqb7m1haNEturM3EXcz3gUqT8d1vEPIWJNCPP2qGr/m7diQtP+SwyrQG3Bf4XGJ1vp
         XjCA==
X-Gm-Message-State: AGRZ1gLt3ukcO6wm7Ni5QQPePF8H3c0LF1p1fk+Goz70iOj9rjv9msWp
        Af6jJ7RCyxXVdamHERfCbho=
X-Google-Smtp-Source: AJdET5cNKfpsbG5nJrnVbQo1NJ9jszyj8crqmDwrqXRCHYB31ylfLgGkMee2ttsXik6Ill030+fjIQ==
X-Received: by 2002:a63:a002:: with SMTP id r2mr1489255pge.212.1541720541447;
        Thu, 08 Nov 2018 15:42:21 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 27-v6sm7652440pfm.36.2018.11.08.15.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 15:42:20 -0800 (PST)
Message-ID: <1541720539.196084.236.camel@acm.org>
Subject: Re: [driver-core PATCH v5 5/9] driver core: Establish clear order
 of operations for deferred probe and remove
From:   Bart Van Assche <bvanassche@acm.org>
To:     Joe Perches <joe@perches.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com
Date:   Thu, 08 Nov 2018 15:42:19 -0800
In-Reply-To: <499e4358e72fca510fa6fcfb76ea3ac3792db08f.camel@perches.com>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
         <154145232484.29224.1635232599636954462.stgit@ahduyck-desk1.jf.intel.com>
         <1541548114.196084.195.camel@acm.org>
         <499e4358e72fca510fa6fcfb76ea3ac3792db08f.camel@perches.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-06 at 17:34 -0800, Joe Perches wrote:
+AD4 On Tue, 2018-11-06 at 15:48 -0800, Bart Van Assche wrote:
+AD4 +AD4 On Mon, 2018-11-05 at 13:12 -0800, Alexander Duyck wrote:
+AD4 +AD4 +AD4 One change I made in addition is I replaced the use of +ACI-bool X:1+ACI to define
+AD4 +AD4 +AD4 the bitfield to a +ACI-u8 X:1+ACI setup in order to resolve some checkpatch
+AD4 +AD4 +AD4 warnings.
+AD4 +AD4 
+AD4 +AD4 Please use +ACI-bool X:1+ACI instead of +ACI-u8 X:1+ACI. I think it was a bad idea to make
+AD4 +AD4 checkpatch complain about +ACI-bool X:1+ACI since +ACI-bool X:1+ACI should only be avoided
+AD4 +AD4 in structures for which alignment must be architecture-independent. For struct
+AD4 +AD4 device it is fine if member alignment differs per architecture. Additionally,
+AD4 +AD4 changing +ACI-bool X:1+ACI into +ACI-u8 X:1+ACI will reduce performance on architectures that
+AD4 +AD4 cannot do byte addressing.
+AD4 
+AD4 I generally agree.  But the checkpatch warning +AF8-could+AF8
+AD4 be useful in those cases where alignment should be
+AD4 architecture-independent.
+AD4 
+AD4 Any suggestion on how to improve the message?

It would be great if a heuristic could be developed that recognizes structs
for which the data layout must be architecture independent. If such a
heuristic could be developed it could be used to only display warn about
+ACI-bool X:n+ACI for such structures.

Bart.
