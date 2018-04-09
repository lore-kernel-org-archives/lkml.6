Return-Path: <dan.j.williams@intel.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523288299; cv=none;
        d=google.com; s=arc-20160816;
        b=vEz+gmQO36gCSQnIuvhlaAyfg/UdFJANbTIOeQHutiyCb/fqdNi2JNe4xHqsiTymZz
         DxCcRgThmnUnoWWQ/t3IzRht2peumGsdXjqq+U95SK4ylvSVOo9YBUOB/JM9VP+ICUTK
         /xJlUwqIbXC1jEL4Uj/IotnEsjcP65Q7JgTOtqMfMea+/sflazzcQ//SYAcgDZBEwxtT
         6JIlw6lBTX9cFvW8LLjzJVoDDZ3kdNuWrF8xbVJ3cAYhMVbGAj2GjGs1LpSgznmKUfXj
         CmMNSnzJj8MUZ9V19oxqGsba47uDQUzTlqdq72rsu+aAPEAPeKmNksK+CZaKeQSDpMGh
         fWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=jCHu9CQBXDgkk6KrRMXW7rra69ATA/yZg6MaHvu0uBw=;
        b=QKtBrhdAd0Iw5G1Cio/v5vL4Jk+zgMXspEgPkRxf+gpBWnQ/L14Safje6etgYFtQJG
         x8+lU4KjeOScPFT3vhPARdtB1TQemQGTTbutAtw7MzSXUSPqRIarSXfrF92tFsNEmszn
         f7N237dR4EhShFYbnwscEYmLF3cy2JLPWkiB1VB9lTndJ6TWtCNPvmk7YuZOZym5orzx
         jH6W1TxhrYaDqdX8O6c1CWLijfFKc+na8uKI8FUqoPz7n0B8FfpoYHkHNgyh6AMewRvO
         XQ9hP/XEz/bHbnfIiJRaGi23Fcvx3M3Jq76LH0TDy7EjHxGytHZvVKUuXuFENtoB3OdP
         4ScA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@intel-com.20150623.gappssmtp.com header.s=20150623 header.b=iVa57riu;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@intel-com.20150623.gappssmtp.com header.s=20150623 header.b=iVa57riu;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
X-Google-Smtp-Source: AIpwx4+uL/PiA9LNOxrSE9M2/PFE4chg80NPQWJKWdorndHXpm7qWz6GnxhrbWQcOuQv55s6VVjKEYFLOXUDBKxmvbc=
MIME-Version: 1.0
In-Reply-To: <20180409090853.GJ19345@localhost.localdomain>
References: <20180408024724.16812-1-bhe@redhat.com> <20180408024724.16812-2-bhe@redhat.com>
 <20180409090853.GJ19345@localhost.localdomain>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 9 Apr 2018 08:38:18 -0700
Message-ID: <CAPcyv4huU32+oMeoF8-HmmctafZ_uOZN-v85O5M8Ka8pBXP+Lg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] resource: Use list_head to link resource sibling
To: Baoquan He <bhe@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, David Airlie <airlied@linux.ie>,
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Stephen Hemminger <sthemmin@microsoft.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	Keith Busch <keith.busch@intel.com>, Jonathan Derrick <jonathan.derrick@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, Brijesh Singh <brijesh.singh@amd.com>,
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
	Wei Yang <richard.weiyang@gmail.com>, devel@linuxdriverproject.org,
	linux-input@vger.kernel.org, linux-nvdimm <linux-nvdimm@lists.01.org>,
	Device Tree <devicetree@vger.kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1597259058407941825?=
X-GMAIL-MSGID: =?utf-8?q?1597283551655294724?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 9, 2018 at 2:08 AM, Baoquan He <bhe@redhat.com> wrote:
> The struct resource uses singly linked list to link siblings. It's not
> easy to do reverse iteration on sibling list. So replace it with list_head.
>
> And code refactoring makes codes in kernel/resource.c more readable than
> pointer operation.
>
> Besides, type of member variables of struct resource, sibling and child, are
> changed from 'struct resource *' to 'struct list_head'. Kernel size will
> increase because of those statically defined struct resource instances.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
[..]
> diff --git a/kernel/resource.c b/kernel/resource.c
> index e270b5048988..473c624606f9 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -31,6 +31,8 @@ struct resource ioport_resource = {
>         .start  = 0,
>         .end    = IO_SPACE_LIMIT,
>         .flags  = IORESOURCE_IO,
> +       .sibling = LIST_HEAD_INIT(ioport_resource.sibling),
> +       .child  = LIST_HEAD_INIT(ioport_resource.child),
>  };
>  EXPORT_SYMBOL(ioport_resource);
>
> @@ -39,6 +41,8 @@ struct resource iomem_resource = {
>         .start  = 0,
>         .end    = -1,
>         .flags  = IORESOURCE_MEM,
> +       .sibling = LIST_HEAD_INIT(iomem_resource.sibling),
> +       .child  = LIST_HEAD_INIT(iomem_resource.child),
>  };
>  EXPORT_SYMBOL(iomem_resource);
>
> @@ -57,20 +61,32 @@ static DEFINE_RWLOCK(resource_lock);
>   * by boot mem after the system is up. So for reusing the resource entry
>   * we need to remember the resource.
>   */
> -static struct resource *bootmem_resource_free;
> +static struct list_head bootmem_resource_free = LIST_HEAD_INIT(bootmem_resource_free);
>  static DEFINE_SPINLOCK(bootmem_resource_lock);
>
> +struct resource *sibling(struct resource *res)
> +{
> +       if (res->parent && !list_is_last(&res->sibling, &res->parent->child))
> +               return list_next_entry(res, sibling);
> +       return NULL;
> +}
> +
> +struct resource *first_child(struct list_head *head)
> +{
> +       return list_first_entry_or_null(head, struct resource, sibling);
> +}
> +

These names are too generic for new global symbols. A "resource_"
prefix is warranted.
