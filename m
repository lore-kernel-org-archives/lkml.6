Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F41AC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 04:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3156D2086E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 04:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3156D2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeJKMYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 08:24:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727332AbeJKMYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 08:24:01 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9B4sRq5051391
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 00:58:31 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n1ypcrgtv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 00:58:30 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 11 Oct 2018 05:58:28 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Oct 2018 05:58:25 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9B4wOAj3932542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Oct 2018 04:58:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06702AE04D;
        Thu, 11 Oct 2018 07:57:08 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51D3DAE045;
        Thu, 11 Oct 2018 07:57:06 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.69])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 11 Oct 2018 07:57:06 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Thu, 11 Oct 2018 07:58:22 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 2/2] docs/core-api: memory-hotplug: add some details about locking internals
Date:   Thu, 11 Oct 2018 07:58:17 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539233897-10207-1-git-send-email-rppt@linux.ibm.com>
References: <1539233897-10207-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18101104-0012-0000-0000-000002B576EC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101104-0013-0000-0000-000020E9D270
Message-Id: <1539233897-10207-3-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Hildenbrand <david@redhat.com>

Let's document the magic a bit, especially why device_hotplug_lock is
required when adding/removing memory and how it all play together with
requests to online/offline memory from user space.

[ rppt: moved the text to Documentation/core-api/memory-hotplug.rst ]

Link: http://lkml.kernel.org/r/20180925091457.28651-7-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: John Allen <jallen@linux.vnet.ibm.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Mathieu Malaterre <malat@debian.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 Documentation/core-api/memory-hotplug.rst | 38 +++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/core-api/memory-hotplug.rst b/Documentation/core-api/memory-hotplug.rst
index a99f2f2..de7467e 100644
--- a/Documentation/core-api/memory-hotplug.rst
+++ b/Documentation/core-api/memory-hotplug.rst
@@ -85,3 +85,41 @@ MEM_ONLINE, or MEM_OFFLINE action to cancel hotplugging. It stops
 further processing of the notification queue.
 
 NOTIFY_STOP stops further processing of the notification queue.
+
+Locking Internals
+=================
+
+When adding/removing memory that uses memory block devices (i.e. ordinary RAM),
+the device_hotplug_lock should be held to:
+
+- synchronize against online/offline requests (e.g. via sysfs). This way, memory
+  block devices can only be accessed (.online/.state attributes) by user
+  space once memory has been fully added. And when removing memory, we
+  know nobody is in critical sections.
+- synchronize against CPU hotplug and similar (e.g. relevant for ACPI and PPC)
+
+Especially, there is a possible lock inversion that is avoided using
+device_hotplug_lock when adding memory and user space tries to online that
+memory faster than expected:
+
+- device_online() will first take the device_lock(), followed by
+  mem_hotplug_lock
+- add_memory_resource() will first take the mem_hotplug_lock, followed by
+  the device_lock() (while creating the devices, during bus_add_device()).
+
+As the device is visible to user space before taking the device_lock(), this
+can result in a lock inversion.
+
+onlining/offlining of memory should be done via device_online()/
+device_offline() - to make sure it is properly synchronized to actions
+via sysfs. Holding device_hotplug_lock is advised (to e.g. protect online_type)
+
+When adding/removing/onlining/offlining memory or adding/removing
+heterogeneous/device memory, we should always hold the mem_hotplug_lock in
+write mode to serialise memory hotplug (e.g. access to global/zone
+variables).
+
+In addition, mem_hotplug_lock (in contrast to device_hotplug_lock) in read
+mode allows for a quite efficient get_online_mems/put_online_mems
+implementation, so code accessing memory can protect from that memory
+vanishing.
-- 
2.7.4

