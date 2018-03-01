Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034203AbeCAUew (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 15:34:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1033189AbeCAUeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 15:34:50 -0500
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI
 Memory
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Dan Williams <dan.j.williams@intel.com>
Cc: Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Oliver OHalloran <oliveroh@au1.ibm.com>
Date: Fri, 02 Mar 2018 07:34:37 +1100
In-Reply-To: <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
References: <20180228234006.21093-1-logang@deltatee.com>
         <1519876489.4592.3.camel@kernel.crashing.org>
         <1519876569.4592.4.camel@au1.ibm.com>
         <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18030120-0016-0000-0000-0000052B9DEA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030120-0017-0000-0000-00002868A417
Message-Id: <1519936477.4592.23.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803010252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-01 at 11:21 -0800, Dan Williams wrote:
> On Wed, Feb 28, 2018 at 7:56 PM, Benjamin Herrenschmidt
> <benh@au1.ibm.com> wrote:
> > On Thu, 2018-03-01 at 14:54 +1100, Benjamin Herrenschmidt wrote:
> > > On Wed, 2018-02-28 at 16:39 -0700, Logan Gunthorpe wrote:
> > > > Hi Everyone,
> > > 
> > > 
> > > So Oliver (CC) was having issues getting any of that to work for us.
> > > 
> > > The problem is that acccording to him (I didn't double check the latest
> > > patches) you effectively hotplug the PCIe memory into the system when
> > > creating struct pages.
> > > 
> > > This cannot possibly work for us. First we cannot map PCIe memory as
> > > cachable. (Note that doing so is a bad idea if you are behind a PLX
> > > switch anyway since you'd ahve to manage cache coherency in SW).
> > 
> > Note: I think the above means it won't work behind a switch on x86
> > either, will it ?
> 
> The devm_memremap_pages() infrastructure allows placing the memmap in
> "System-RAM" even if the hotplugged range is in PCI space. So, even if
> it is an issue on some configurations, it's just a simple adjustment
> to where the memmap is placed.

But what happens with that PCI memory ? Is it effectively turned into
nromal memory (ie, usable for normal allocations, potentially used to
populate user pages etc...) or is it kept aside ?

Also on ppc64, the physical addresses of PCIe make it so far appart
that there's no way we can map them into the linear mapping at the
normal offset of PAGE_OFFSET + (pfn << PAGE_SHIFT), so things like
page_address or virt_to_page cannot work as-is on PCIe addresses.

Ben.
