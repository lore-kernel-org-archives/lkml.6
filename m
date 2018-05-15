Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbeEOG70 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:59:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33310 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752271AbeEOG7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:59:23 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [RFC] mm, THP: Map read-only text segments using large THP pages
From: William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <010001635f3c42d3-ed92871f-4fba-47dc-9750-69a40dd07ab6-000000@email.amazonses.com>
Date: Tue, 15 May 2018 00:59:16 -0600
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Message-Id: <D4359A94-6E95-4D89-B9F3-7A6CDB50C0A1@oracle.com>
References: <5BB682E1-DD52-4AA9-83E9-DEF091E0C709@oracle.com>
 <010001635f3c42d3-ed92871f-4fba-47dc-9750-69a40dd07ab6-000000@email.amazonses.com>
To: Christopher Lameter <cl@linux.com>
X-Mailer: Apple Mail (2.3445.8.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8893 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=699
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805150073
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4F6xSdP024352



> On May 14, 2018, at 9:19 AM, Christopher Lameter <cl@linux.com> wrote:
> 
> Cool. This could be controlled by the faultaround logic right? If we get
> fault_around_bytes up to huge page size then it is reasonable to use a
> huge page directly.

It isn't presently but certainly could be; for the prototype it tries to
map a large page when needed and, should that fail, it will fall through
to the normal fault around code.

I would think we would want a separate parameter, as I can see the usefulness
of more fine-grained control. Many users may want to try mapping a large page
if possible, but would prefer a smaller number of bytes to be read in fault
around should we need to fall back to using PAGESIZE pages.

> fault_around_bytes can be set via sysfs so there is a natural way to
> control this feature there I think.

I agree; perhaps I could use "fault_around_thp_bytes" or something similar.

>> Since this approach will map a PMD size block of the memory map at a time, we
>> should see a slight uptick in time spent in disk I/O but a substantial drop in
>> page faults as well as a reduction in iTLB misses as address ranges will be
>> mapped with the larger page. Analysis of a test program that consists of a very
>> large text area (483,138,032 bytes in size) that thrashes D$ and I$ shows this
>> does occur and there is a slight reduction in program execution time.
> 
> I think we would also want such a feature for regular writable pages as
> soon as possible.

That is my ultimate long-term goal for this project - full r/w support of large
THP pages; prototyping with read-only text pages seemed like the best first step
to get a sense of the possible benefits.

  -- Bill
