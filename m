Return-Path: <robert.m.harris@oracle.com>
X-Google-Smtp-Source: AH8x224Xc3WsDCPT9tE81fBmiWD33Q2G8t5KN/OhgiuT1zjCKxP4nnKGlTKCHWx+7G1t8diKn42j
ARC-Seal: i=1; a=rsa-sha256; t=1518972368; cv=none;
        d=google.com; s=arc-20160816;
        b=T8lubhldpbM4nmyqffnSxHgSuDxkGCQR/FlqFxnEN//Nf//DP0PdK98bs7UFUJnquB
         lOcT9z7xliicNeZYNLs/FtGNTGHiZpbW5WBoKeVC8BeuNg6rVLOUFSuylBLVPv3Nx5Kp
         y5NiHgoUg1IS/ddn5y3mjmCCQiaBtWPi10QBStTzaQM+Wm/2pCvqKy75fSwGLzKJWXXz
         rzvMt3C++vt4ZyXlUEPNEqPJZXbCn47Nk6Gd2k2DO9jbc1o6qvVMl+sCfacUDSVdBUr4
         KTu7FJZ4uv/6sX6njLFhVSrSZeFWqY9K3mah4wuwx6o8uZCdih7zxhGnmaGrhV0DWKsX
         hSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=rPvdbfwIMX+kvkmYylRDcpj4BjS1fEIHToYoqLBmEpM=;
        b=S/25/QGYdL7gmtyJrQK/bsTUcGhFOhIx7Guo2CP9HFFLOWlflDMzXjTHjxJ5KMrTWc
         apYEbksiL3mE+VtGQ0M157cpUMEwzTnHQPLNgbV/yJhKSPlyyXOylvrrEZ3xXpuYZ/od
         rat97DXs1VOxs+V+8EzNi3hsksQKUtyPk7EU9i8zstJKO277NeVy3KHpMqNyzSrNKCGC
         5U2pu7ciYL9vV4mzPyL8nF8Oel5w3oDkUvkukpk3VqEWD1aR5i2LTARK9zt5InXzXf6Q
         qitwDgK/mFDiKAwSQkvP4KAxd4d0fEswd5/Bec4/v0IDwlpre0qiO5JS23HclYZyf219
         EEQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=cASkFa+d;
       spf=pass (google.com: domain of robert.m.harris@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=robert.m.harris@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=cASkFa+d;
       spf=pass (google.com: domain of robert.m.harris@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=robert.m.harris@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: robert.m.harris@oracle.com
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Kemi Wang <kemi.wang@intel.com>,
        David Rientjes <rientjes@google.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kangmin Park <l4stpr0gr4m@gmail.com>, Mel Gorman <mgorman@suse.de>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        "Robert M. Harris" <robert.m.harris@oracle.com>
Subject: [PATCH 0/1] mm, compaction: correct the bounds of __fragmentation_index()
Date: Sun, 18 Feb 2018 16:47:54 +0000
Message-Id: <1518972475-11340-1-git-send-email-robert.m.harris@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8808 signatures=668674
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=739
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802180225
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592757962533260207?=
X-GMAIL-MSGID: =?utf-8?q?1592757969843047879?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Robert M. Harris" <robert.m.harris@oracle.com>

__fragmentation_index() calculates a value used to determine whether
compaction should be favoured over page reclaim in the event of
allocation failure.  The function purports to return a value between 0
and 1000, representing units of 1/1000.  Barring the case of a
pathological shortfall of memory, the lower bound is instead 500.  This
is significant because it is the default value of
sysctl_extfrag_threshold, i.e. the value below which compaction should
be avoided in favour of page reclaim for costly pages.

Here's an illustration using a zone that I fragmented with selective
calls to __alloc_pages() and __free_pages --- the fragmentation for
order-1 could not be minimised further yet is reported as 0.5:

# head -1 /proc/buddyinfo
Node 0, zone      DMA   1983      0      0      0      0      0      0      0      0      0      0 
# head -1 /sys/kernel/debug/extfrag/extfrag_index
Node 0, zone      DMA -1.000 0.500 0.750 0.875 0.937 0.969 0.984 0.992 0.996 0.998 0.999 
# 

With extreme memory shortage the reported fragmentation index does go
lower.  In fact, it can go below zero:

# head -1 /proc/buddyinfo
Node 0, zone      DMA      1      0      0      0      0      0      0      0      0      0      0 
# head -1 /sys/kernel/debug/extfrag/extfrag_index
Node 0, zone      DMA -1.000 0.-500 0.-250 0.-125 0.-62 0.-31 0.-15 0.-07 0.-03 0.-01 0.000 
# 

This patch implements and documents a modified version of the original
expression that returns a value in the range 0 <= index < 1000.  It
amends the default value of sysctl_extfrag_threshold to preserve the
existing behaviour.  With this patch in place, the same two tests yield

# head -1 /proc/buddyinfo
Node 0, zone      DMA   1983      0      0      0      0      0      0      0      0      0      0 
# head -1 /sys/kernel/debug/extfrag/extfrag_index
Node 0, zone      DMA -1.000 0.000 0.500 0.750 0.875 0.937 0.969 0.984 0.992 0.996 0.998 
# 

and

# head -1 /proc/buddyinfo
Node 0, zone      DMA      1      0      0      0      0      0      0      0      0      0      0 
# head -1 /sys/kernel/debug/extfrag/extfrag_index
Node 0, zone      DMA -1.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 
# 

Robert M. Harris (1):
  mm, compaction: correct the bounds of __fragmentation_index()

 Documentation/sysctl/vm.txt |  2 +-
 mm/compaction.c             |  2 +-
 mm/vmstat.c                 | 47 +++++++++++++++++++++++++++++++++++----------
 3 files changed, 39 insertions(+), 12 deletions(-)

-- 
1.8.3.1
