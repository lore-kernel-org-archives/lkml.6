Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeA3Jx5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:53:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751273AbeA3Jxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:53:55 -0500
Date: Tue, 30 Jan 2018 15:23:45 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        pasha.tatashin@oracle.com
Subject: Re: Memory hotplug not increasing the total RAM
Reply-To: bharata@linux.vnet.ibm.com
References: <20180130083006.GB1245@in.ibm.com>
 <20180130091600.GA26445@dhcp22.suse.cz>
 <20180130092815.GR21609@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130092815.GR21609@dhcp22.suse.cz>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-TM-AS-GCONF: 00
x-cbid: 18013009-0040-0000-0000-0000042A5E97
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18013009-0041-0000-0000-000020CDF649
Message-Id: <20180130095345.GC1245@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1801300127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 10:28:15AM +0100, Michal Hocko wrote:
> On Tue 30-01-18 10:16:00, Michal Hocko wrote:
> > On Tue 30-01-18 14:00:06, Bharata B Rao wrote:
> > > Hi,
> > > 
> > > With the latest upstream, I see that memory hotplug is not working
> > > as expected. The hotplugged memory isn't seen to increase the total
> > > RAM pages. This has been observed with both x86 and Power guests.
> > > 
> > > 1. Memory hotplug code intially marks pages as PageReserved via
> > > __add_section().
> > > 2. Later the struct page gets cleared in __init_single_page().
> > > 3. Next online_pages_range() increments totalram_pages only when
> > >    PageReserved is set.
> > 
> > You are right. I have completely forgot about this late struct page
> > initialization during onlining. memory hotplug really doesn't want
> > zeroying. Let me think about a fix.
> 
> Could you test with the following please? Not an act of beauty but
> we are initializing memmap in sparse_add_one_section for memory
> hotplug. I hate how this is different from the initialization case
> but there is quite a long route to unify those two... So a quick
> fix should be as follows.

Tested on Power guest, fixes the issue. I can now see the total memory
size increasing after hotplug.

Regards,
Bharata.
