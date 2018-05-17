Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeERCKJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 22:10:09 -0400
Received: from p3plsmtpa12-03.prod.phx3.secureserver.net ([68.178.252.232]:47591
        "EHLO p3plsmtpa12-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751564AbeERCKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 22:10:07 -0400
Subject: Re: [RFC PATCH 00/09] Implement direct user I/O interfaces for RDMA
To: longli@microsoft.com, Steve French <sfrench@samba.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20180518002214.5657-1-longli@linuxonhyperv.com>
From: Tom Talpey <tom@talpey.com>
Message-ID: <d5eaf67d-4b0d-9206-a016-67cb3b5a0df8@talpey.com>
Date: Thu, 17 May 2018 19:10:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518002214.5657-1-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHJWMPRfaqyTk9DV8ZW4EahqaTPlu2M9KFb/sqq221lmKoc7I5LW6PUi+4Pz893oent8F5hxIE6nA31l04DxdCBaG6XYy2RYo8B4WgM+0qTy3NM3NHAP
 c+25MfKyhQoRko+Pgdax8bK/Si0n/36WMefNqvybYsQrPNrT2Clw2cPuRbPbxe/VmaUrxTxs+OElk+KbqteXscgLYCZ0Z9306Uh6Nt3AZ3K9/W3hcWkVAPX6
 SoaEjd5Aeyl/BPQP3JmQt20SPqRy3AFVZgsDUKPuleiyEwzZOKRaKSLU+4LHsRHePVUAnKvjAos5KRqD+3pc5M92qdfjj3hAg0r6phgacseuf/EmZcTFsALC
 s+N+RNQp
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/2018 8:22 PM, Long Li wrote:
> From: Long Li <longli@microsoft.com>
> 
> This patchset implements direct user I/O through RDMA.
> 
> In normal code path (even with cache=none), CIFS copies I/O data from
> user-space to kernel-space for security reasons.
> 
> With this patchset, a new mounting option is introduced to have CIFS pin the
> user-space buffer into memory and performs I/O through RDMA. This avoids memory
> copy, at the cost of added security risk.

What's the security risk? This type of direct i/o behavior is not
uncommon, and can certainly be made safe, using the appropriate
memory registration and protection domains. Any risk needs to be
stated explicitly, and mitigation provided, or at least described.

Tom.

> 
> This patchset is RFC. The work is in progress, do not merge.
> 
> 
> Long Li (9):
>    Introduce offset for the 1st page in data transfer structures
>    Change wdata alloc to support direct pages
>    Change rdata alloc to support direct pages
>    Change function to support offset when reading pages
>    Change RDMA send to regonize page offset in the 1st page
>    Change RDMA recv to support offset in the 1st page
>    Support page offset in memory regsitrations
>    Implement no-copy file I/O interfaces
>    Introduce cache=rdma moutning option
>   
> 
>   fs/cifs/cifs_fs_sb.h      |   2 +
>   fs/cifs/cifsfs.c          |  19 +++
>   fs/cifs/cifsfs.h          |   3 +
>   fs/cifs/cifsglob.h        |   6 +
>   fs/cifs/cifsproto.h       |   4 +-
>   fs/cifs/cifssmb.c         |  10 +-
>   fs/cifs/connect.c         |  13 +-
>   fs/cifs/dir.c             |   5 +
>   fs/cifs/file.c            | 351 ++++++++++++++++++++++++++++++++++++++++++----
>   fs/cifs/inode.c           |   4 +-
>   fs/cifs/smb2ops.c         |   2 +-
>   fs/cifs/smb2pdu.c         |  22 ++-
>   fs/cifs/smbdirect.c       | 132 ++++++++++-------
>   fs/cifs/smbdirect.h       |   2 +-
>   fs/read_write.c           |   7 +
>   include/linux/ratelimit.h |   2 +-
>   16 files changed, 489 insertions(+), 95 deletions(-)
> 
