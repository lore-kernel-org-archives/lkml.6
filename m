Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5210BC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1123C20861
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1123C20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbeIHG7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 02:59:06 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:36584
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbeIHG7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 02:59:05 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id ySl5fa5TKTEX4ySl5f1l1a; Fri, 07 Sep 2018 19:14:19 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1fySl5-0005DL-K8; Fri, 07 Sep 2018 19:13:59 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v3 00/16] CIFS: add support for direct I/O
Date:   Sat,  8 Sep 2018 02:13:32 +0000
Message-Id: <20180908021348.19956-1-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfJqy+5iG24CzfnCPxNSaHjaUBkur9CrCdYfcww1FU1IuXVCk2RJQ6s0In35BHNrgJPYYwK3jq1weVTgaF1SHlhhMRn6IQ0gl8H2QVVtKDj3zQQTgQrF5
 yg1/cesE3NIMgja5Pfjb0XC9owv/WU1LWEDaMEohHccDyZeLhYZeTR67QV5H1zQcVs2PkKCQw6E5v9NTW1c81TkmBVw4T0PKqAFSwmyuCCrfQvW/wqT63QcP
 NVk23bpe03sDWHyzpMgn4CFfbR7fyQmIbJKF/7qlFmMpWAh70g8rudCLVgjs28bEbSNU6GmGJjhnddzZ28GyjqAFOElRWH8oDMWRXsa+7q0A18QJ7IKePcEH
 gHxu3xfL6k+MUUEHbmzJ8T2gxWDnEsK33FAd3XyWMNDCQ6WThRr5aYRLDANAxVpyqEhWg15q
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

This patch set implements direct I/O.

In normal code path (even with cache=none), CIFS copies I/O data from
user-space to kernel-space for security reasons of possible protocol
required signing and encryption on user data.

With this patch set, CIFS passes the I/O data directly from user-space
buffer to the transport layer, when file system is mounted with
"cache-none".

Patch v2 addressed comments from Christoph Hellwig <hch@lst.de> and
Tom Talpey <ttalpey@microsoft.com> to implement direct I/O for both
socket and RDMA.

Patch v3 added support for kernel AIO.


Long Li (16):
  CIFS: Add support for direct pages in rdata
  CIFS: Use offset when reading pages
  CIFS: Add support for direct pages in wdata
  CIFS: pass page offset when issuing SMB write
  CIFS: Calculate the correct request length based on page offset and
    tail size
  CIFS: Introduce helper function to get page offset and length in
    smb_rqst
  CIFS: When sending data on socket, pass the correct page offset
  CIFS: SMBD: Support page offset in RDMA send
  CIFS: SMBD: Support page offset in RDMA recv
  CIFS: SMBD: Do not call ib_dereg_mr on invalidated memory registration
  CIFS: SMBD: Support page offset in memory registration
  CIFS: Pass page offset for calculating signature
  CIFS: Pass page offset for encrypting
  CIFS: Add support for direct I/O read
  CIFS: Add support for direct I/O write
  CIFS: Add direct I/O functions to file_operations

 fs/cifs/cifsencrypt.c |   9 +-
 fs/cifs/cifsfs.c      |  10 +-
 fs/cifs/cifsfs.h      |   2 +
 fs/cifs/cifsglob.h    |  11 +-
 fs/cifs/cifsproto.h   |   9 +-
 fs/cifs/cifssmb.c     |  19 +-
 fs/cifs/connect.c     |   5 +-
 fs/cifs/file.c        | 477 ++++++++++++++++++++++++++++++++++++++++++--------
 fs/cifs/misc.c        |  17 ++
 fs/cifs/smb2ops.c     |  22 ++-
 fs/cifs/smb2pdu.c     |  20 ++-
 fs/cifs/smbdirect.c   | 156 ++++++++++-------
 fs/cifs/smbdirect.h   |   2 +-
 fs/cifs/transport.c   |  34 ++--
 14 files changed, 606 insertions(+), 187 deletions(-)

-- 
2.7.4

