Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755691AbeDZM1q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:27:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754723AbeDZM1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:27:44 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Pankaj Gupta <pagupta@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>, Linux MM <linux-mm@kvack.org>,
        Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Haozhong Zhang <haozhong.zhang@intel.com>,
        Nitesh Narayan Lal <nilal@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Zwisler\, Ross" <ross.zwisler@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, niteshnarayanlal@hotmail.com,
        Igor Mammedov <imammedo@redhat.com>, lcapitulino@redhat.com
Subject: Re: [RFC v2 1/2] virtio: add pmem driver
References: <20180425112415.12327-1-pagupta@redhat.com>
        <20180425112415.12327-2-pagupta@redhat.com>
        <CAPcyv4hvrB08XPTbVK0xT2_1Xmaid=-v3OMxJVDTNwQucsOHLA@mail.gmail.com>
        <CAPcyv4hiowWozV527sQA_e4fdgCYbD6xfG==vepAqu0hxQEQcw@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Date: Thu, 26 Apr 2018 08:27:41 -0400
In-Reply-To: <CAPcyv4hiowWozV527sQA_e4fdgCYbD6xfG==vepAqu0hxQEQcw@mail.gmail.com>
        (Dan Williams's message of "Wed, 25 Apr 2018 07:43:52 -0700")
Message-ID: <x49o9i6885e.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> [ adding Jeff directly since he has also been looking at
> infrastructure to track when MAP_SYNC should be disabled ]
>
> On Wed, Apr 25, 2018 at 7:21 AM, Dan Williams <dan.j.williams@intel.com> wrote:
>> On Wed, Apr 25, 2018 at 4:24 AM, Pankaj Gupta <pagupta@redhat.com> wrote:
>>> This patch adds virtio-pmem driver for KVM
>>> guest.
>>
>> Minor nit, please expand your changelog line wrapping to 72 columns.
>>
>>>
>>> Guest reads the persistent memory range
>>> information from Qemu over VIRTIO and registers
>>> it on nvdimm_bus. It also creates a nd_region
>>> object with the persistent memory range
>>> information so that existing 'nvdimm/pmem'
>>> driver can reserve this into system memory map.
>>> This way 'virtio-pmem' driver uses existing
>>> functionality of pmem driver to register persistent
>>> memory compatible for DAX capable filesystems.
>>
>> We need some additional enabling to disable MAP_SYNC for this

enable to disable... I like it!  ;-)

>> configuration. In other words, if fsync() is required then we must
>> disable the MAP_SYNC optimization. I think this should be a struct
>> dax_device property looked up at mmap time in each MAP_SYNC capable
>> ->mmap() file operation implementation.

Ideally, qemu (seabios?) would advertise a platform capabilities
sub-table that doesn't fill in the flush bits.

-Jeff
