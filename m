Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161621AbeCAUdH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 15:33:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1161584AbeCAUdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 15:33:02 -0500
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI
 Memory
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Oliver OHalloran <oliveroh@au1.ibm.com>
Date: Fri, 02 Mar 2018 07:32:48 +1100
In-Reply-To: <B4151146-0490-40D4-BB0A-4FC9DE5841A4@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
         <1519876489.4592.3.camel@kernel.crashing.org>
         <1519876569.4592.4.camel@au1.ibm.com>
         <B4151146-0490-40D4-BB0A-4FC9DE5841A4@raithlin.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18030120-0040-0000-0000-000004399C6A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030120-0041-0000-0000-000020DCA254
Message-Id: <1519936368.4592.21.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803010251
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-01 at 18:09 +0000, Stephen  Bates wrote:
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
> >   
> >   Note: I think the above means it won't work behind a switch on x86
> >   either, will it ?
> 
>  
> Ben 
> 
> We have done extensive testing of this series and its predecessors
> using PCIe switches from both Broadcom (PLX) and Microsemi. We have
> also done testing on x86_64, ARM64 and ppc64el based ARCH with
> varying degrees of success. The series as it currently stands only
> works on x86_64 but modified (hacky) versions have been made to work
> on ARM64. The x86_64 testing has been done on a range of (Intel)
> CPUs, servers, PCI EPs (including RDMA NICs from at least three
> vendors, NVMe SSDs from at least four vendors and P2P devices from
> four vendors) and PCI switches.
> 
> I do find it slightly offensive that you would question the series
> even working. I hope you are not suggesting we would submit this
> framework multiple times without having done testing on it....

No need to get personal on that. I did specify that this was based on
some incomplete understanding of what's going on with that new hack
used to create struct pages.

As it is, it cannot work on ppc64 however, in part because according to
Oliver, we end up mapping things cachable, and in part, because of the
address range issues.

The latter issue might be fundamental to the approach and unfixable
unless we have ways to use hooks for virt_to_page/page_address on these
things.

Ben.
