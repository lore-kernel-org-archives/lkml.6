Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756843AbeDZRPm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 13:15:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754419AbeDZRPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 13:15:39 -0400
Date: Thu, 26 Apr 2018 13:15:38 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc: Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>,
        Ross Zwisler <ross.zwisler@intel.com>,
        Qemu Developers <qemu-devel@nongnu.org>, lcapitulino@redhat.com,
        Linux MM <linux-mm@kvack.org>, niteshnarayanlal@hotmail.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Haozhong Zhang <haozhong.zhang@intel.com>,
        Rik van Riel <riel@surriel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Igor Mammedov <imammedo@redhat.com>
Message-ID: <1499190564.23017177.1524762938762.JavaMail.zimbra@redhat.com>
In-Reply-To: <x49o9i6885e.fsf@segfault.boston.devel.redhat.com>
References: <20180425112415.12327-1-pagupta@redhat.com> <20180425112415.12327-2-pagupta@redhat.com> <CAPcyv4hvrB08XPTbVK0xT2_1Xmaid=-v3OMxJVDTNwQucsOHLA@mail.gmail.com> <CAPcyv4hiowWozV527sQA_e4fdgCYbD6xfG==vepAqu0hxQEQcw@mail.gmail.com> <x49o9i6885e.fsf@segfault.boston.devel.redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 1/2] virtio: add pmem driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.119, 10.4.195.13]
Thread-Topic: virtio: add pmem driver
Thread-Index: /imvhUOXH3u4LmxyH8rb+mLcULCcBw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > [ adding Jeff directly since he has also been looking at
> > infrastructure to track when MAP_SYNC should be disabled ]
> >
> > On Wed, Apr 25, 2018 at 7:21 AM, Dan Williams <dan.j.williams@intel.com>
> > wrote:
> >> On Wed, Apr 25, 2018 at 4:24 AM, Pankaj Gupta <pagupta@redhat.com> wrote:
> >>> This patch adds virtio-pmem driver for KVM
> >>> guest.
> >>
> >> Minor nit, please expand your changelog line wrapping to 72 columns.
> >>
> >>>
> >>> Guest reads the persistent memory range
> >>> information from Qemu over VIRTIO and registers
> >>> it on nvdimm_bus. It also creates a nd_region
> >>> object with the persistent memory range
> >>> information so that existing 'nvdimm/pmem'
> >>> driver can reserve this into system memory map.
> >>> This way 'virtio-pmem' driver uses existing
> >>> functionality of pmem driver to register persistent
> >>> memory compatible for DAX capable filesystems.
> >>
> >> We need some additional enabling to disable MAP_SYNC for this
> 
> enable to disable... I like it!  ;-)
> 
> >> configuration. In other words, if fsync() is required then we must
> >> disable the MAP_SYNC optimization. I think this should be a struct
> >> dax_device property looked up at mmap time in each MAP_SYNC capable
> >> ->mmap() file operation implementation.

I understand you mean we want to disable 'MAP_SYNC' optimization as
we are relying on additional fsync. You mean if we add a property/flag
in dax_device struct and its set, disable 'MAP_SYNC' accordingly during
mmap time for corresponding filesystems?  

> 
> Ideally, qemu (seabios?) would advertise a platform capabilities
> sub-table that doesn't fill in the flush bits.

Could you please elaborate on this, how its related to disabling
MAP_SYNC? We are not doing entire nvdimm device emulation. 

> 
> -Jeff
> 
> 
