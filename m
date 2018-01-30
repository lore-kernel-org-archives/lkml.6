Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeA3IaS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 03:30:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751759AbeA3IaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 03:30:16 -0500
Date: Tue, 30 Jan 2018 14:00:06 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: pasha.tatashin@oracle.com
Subject: Memory hotplug not increasing the total RAM
Reply-To: bharata@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
X-TM-AS-GCONF: 00
x-cbid: 18013008-0008-0000-0000-000004C75880
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18013008-0009-0000-0000-00001E5AEDAA
Message-Id: <20180130083006.GB1245@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1801300108
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With the latest upstream, I see that memory hotplug is not working
as expected. The hotplugged memory isn't seen to increase the total
RAM pages. This has been observed with both x86 and Power guests.

1. Memory hotplug code intially marks pages as PageReserved via
__add_section().
2. Later the struct page gets cleared in __init_single_page().
3. Next online_pages_range() increments totalram_pages only when
   PageReserved is set.

The step 2 has been introduced recently by the following commit:

commit f7f99100d8d95dbcf09e0216a143211e79418b9f
Author: Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed Nov 15 17:36:44 2017 -0800

    mm: stop zeroing memory during allocation in vmemmap
    
Reverting this commit restores the correct behaviour of memory hotplug.

Regards,
Bharata.
