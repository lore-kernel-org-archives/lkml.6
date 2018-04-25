Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754609AbeDYOVY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:21:24 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34585 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754400AbeDYOVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:21:22 -0400
X-Google-Smtp-Source: AB8JxZpDnuld7Fwvs0gF9QKpFnDwMlXmCrhgcepLw0aeRZHt8cBNQquMuq1Hj3GlfU1dH64Jj6xVhbEiQfsDUeOezCk=
MIME-Version: 1.0
In-Reply-To: <20180425112415.12327-2-pagupta@redhat.com>
References: <20180425112415.12327-1-pagupta@redhat.com> <20180425112415.12327-2-pagupta@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 25 Apr 2018 07:21:21 -0700
Message-ID: <CAPcyv4hvrB08XPTbVK0xT2_1Xmaid=-v3OMxJVDTNwQucsOHLA@mail.gmail.com>
Subject: Re: [RFC v2 1/2] virtio: add pmem driver
To: Pankaj Gupta <pagupta@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>, Linux MM <linux-mm@kvack.org>,
        Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Haozhong Zhang <haozhong.zhang@intel.com>,
        Nitesh Narayan Lal <nilal@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Zwisler, Ross" <ross.zwisler@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, niteshnarayanlal@hotmail.com,
        Igor Mammedov <imammedo@redhat.com>, lcapitulino@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 4:24 AM, Pankaj Gupta <pagupta@redhat.com> wrote:
> This patch adds virtio-pmem driver for KVM
> guest.

Minor nit, please expand your changelog line wrapping to 72 columns.

>
> Guest reads the persistent memory range
> information from Qemu over VIRTIO and registers
> it on nvdimm_bus. It also creates a nd_region
> object with the persistent memory range
> information so that existing 'nvdimm/pmem'
> driver can reserve this into system memory map.
> This way 'virtio-pmem' driver uses existing
> functionality of pmem driver to register persistent
> memory compatible for DAX capable filesystems.

We need some additional enabling to disable MAP_SYNC for this
configuration. In other words, if fsync() is required then we must
disable the MAP_SYNC optimization. I think this should be a struct
dax_device property looked up at mmap time in each MAP_SYNC capable
->mmap() file operation implementation.
