Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753757AbeENPTh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:19:37 -0400
Received: from a9-54.smtp-out.amazonses.com ([54.240.9.54]:36840 "EHLO
        a9-54.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753080AbeENPTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:19:36 -0400
Date: Mon, 14 May 2018 15:19:34 +0000
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: William Kucharski <william.kucharski@oracle.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] mm, THP: Map read-only text segments using large THP
 pages
In-Reply-To: <5BB682E1-DD52-4AA9-83E9-DEF091E0C709@oracle.com>
Message-ID: <010001635f3c42d3-ed92871f-4fba-47dc-9750-69a40dd07ab6-000000@email.amazonses.com>
References: <5BB682E1-DD52-4AA9-83E9-DEF091E0C709@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.05.14-54.240.9.54
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2018, William Kucharski wrote:

> The idea is that the kernel will attempt to allocate and map the range using a
> PMD sized THP page upon first fault; if the allocation is successful the page
> will be populated (at present using a call to kernel_read()) and the page will
> be mapped at the PMD level. If memory allocation fails, the page fault routines
> will drop through to the conventional PAGESIZE-oriented routines for mapping
> the faulting page.

Cool. This could be controlled by the faultaround logic right? If we get
fault_around_bytes up to huge page size then it is reasonable to use a
huge page direcly.

fault_around_bytes can be set via sysfs so there is a natural way to
control this feature there I think.


> Since this approach will map a PMD size block of the memory map at a time, we
> should see a slight uptick in time spent in disk I/O but a substantial drop in
> page faults as well as a reduction in iTLB misses as address ranges will be
> mapped with the larger page. Analysis of a test program that consists of a very
> large text area (483,138,032 bytes in size) that thrashes D$ and I$ shows this
> does occur and there is a slight reduction in program execution time.

I think we would also want such a feature for regular writable pages as
soon as possible.
