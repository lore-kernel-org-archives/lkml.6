Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932547AbeE3Tw1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:52:27 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:60154
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932248AbeE3Ttv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:49:51 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [Patch v2 00/15] CIFS: Add direct I/O support
Date: Wed, 30 May 2018 12:47:52 -0700
Message-Id: <20180530194807.31657-1-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.0
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfOXTRW/GUneQYLoecZdiasFtUNNpaLz/S4ZgqJTHTd47qxTI9hnEpOeZuC3eJfSjt+3HCyi7Xh8iGB7Q73GOCL/4yhlKfWu5dEKGWxcRadQzcMXOxlXd
 lPIyqCpuY3Fpk5GlN27fT/4RbBc0B//xwgIYBEpHh61YbXPQZH9qNQ0SFm9+zY23JX9QyDmh09Lvr526uu96D7CNyE7TXgRakqRr/NRMXz96JGtn/uOElhXq
 M2ZH3M+W6JmHn7pHE/2e7SgJfcvwrOKphbHscKRUo3LkP/RXske6Gvh00LaKe3acLBJjpWx8lp/Rwiremo1/KidT/AWevz1iZl6ZPygNImcHJad4Cs+PaBJ2
 bcGEATleor/q1coFObJGUz+zC/Eu7P5xdGxb7g6wZRzx6okCjfRi5dJ2S08bNb1u6redKPed
Sender: linux-kernel-owner@vger.kernel.org
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


Long Li (15):
  CIFS: Introduce offset for the 1st page in data transfer structures
  CIFS: Add support for direct pages in rdata
  CIFS: Use offset when reading pages
  CIFS: Add support for direct pages in wdata
  CIFS: Calculate the correct request length based on page offset and
    tail size
  CIFS: Introduce helper function to get page offset and length in
    smb_rqst
  CIFS: When sending data on socket, pass the correct page offset
  CIFS: SMBD: Support page offset in RDMA send
  CIFS: SMBD: Support page offset in RDMA recv
  CIFS: SMBD: Support page offset in memory registration
  CIFS: Pass page offset for calculating signature
  CIFS: Pass page offset for encrypting
  CIFS: Add support for direct I/O read
  CIFS: Add support for direct I/O write
  CIFS: Add direct I/O functions to file_operations

 fs/cifs/cifsencrypt.c |   9 +-
 fs/cifs/cifsfs.c      |   5 +-
 fs/cifs/cifsfs.h      |   2 +
 fs/cifs/cifsglob.h    |   7 +-
 fs/cifs/cifsproto.h   |   9 +-
 fs/cifs/cifssmb.c     |  17 ++-
 fs/cifs/connect.c     |   5 +-
 fs/cifs/file.c        | 389 +++++++++++++++++++++++++++++++++++++++++++++++---
 fs/cifs/misc.c        |  17 +++
 fs/cifs/smb2ops.c     |  22 +--
 fs/cifs/smb2pdu.c     |  20 ++-
 fs/cifs/smbdirect.c   | 121 ++++++++++------
 fs/cifs/smbdirect.h   |   2 +-
 fs/cifs/transport.c   |  34 +++--
 14 files changed, 554 insertions(+), 105 deletions(-)

-- 
2.7.4
