Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526328243; cv=none;
        d=google.com; s=arc-20160816;
        b=jLx44rpgFMuVww6JbarjakJ3r0ekWD7rNZIPGJbmhSDxTq/lUIUxPgX20v4jnPLysV
         3aYkaON4yRBnP/t4f5cjC/qD1cXOXp+LjAlB/kvVfro2dzLnOIg59ChPudokhcEjCZSJ
         Kn2n2854sD25rVmrvti+iS2+1+FLnzKt4bn0PDBOYFikGnO62es+DfX6Ca4yPu2RlboH
         XT7wuA3CcJHtI6jVjMAvVtqmfE0esJFFkGrwSM/VBAh7vgIUFPxBDG1BmhKqPKjTF3LF
         VX4QneNc2GDam/MBuXT/FcpuyA8IUhI2vNTHHwDi+4CBGwCt/9Zk7r7hQYgIYCAk/a11
         DlpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=gQCV5aADvJyVb33k0Uw6Y9lyjw2tNhgyBQHjOCYE2t8=;
        b=F2XDdpZK8ECvNPUl+gHo9knhd6QDCsyrt6/jodx+9YHPAoWqCquvvtL9ke4O0sIa9D
         PDDS2G9g8N8nGuqFNUhd5PxEyztSK6RQodWd2FuQoFp2JAVjYD74LW1y2Mw4udlBGxVS
         t+HzToWn6JIpDaaGSMOdV8hvJ9G+yRoZi97fPnw4fm2Mxa/31I8T0VbmtxM6byrEL3k4
         y/LAo5AAdNDeMq7W9/2auQNp0AqovkC6/3H4gFAqFfppSb2X+xL1XFHND0UpLePQeJ7/
         RF72pSMgr5h/ZxmKAJTWkKV8ySReLmaV82gPwnJU8jCT5sxCO3nkK9yKFjk2LSP6ck/b
         lamA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iXwaLLnH;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iXwaLLnH;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZodoQZyoFpzHIdRLrubynhCyeD2R/WgK+e9TRL5KndQWl6d3mtNpB00GylSYcdXv7VuQ5SIijZPCoTiso5X+1I=
MIME-Version: 1.0
In-Reply-To: <20180514194254.14748-2-pasha.tatashin@oracle.com>
References: <20180514194254.14748-1-pasha.tatashin@oracle.com> <20180514194254.14748-2-pasha.tatashin@oracle.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 May 2018 23:04:02 +0300
Message-ID: <CAHp75VeopFMFHq=rJCUcAw02kznJ5+0vLWr5500DsGtERiX6cw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] drivers core: multi-threading device shutdown
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>, intel-wired-lan@lists.osuosl.org,
	netdev <netdev@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alexander.duyck@gmail.com, tobin@apporbit.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600469847842803826?=
X-GMAIL-MSGID: =?utf-8?q?1600471164399462760?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 10:42 PM, Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:

>  #include <linux/netdevice.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sysfs.h>
> +#include <linux/kthread.h>

Can we still preserve an order here? (Yes, even if the entire list is
not fully ordered)
In the context I see it would go before netdevice.h.

> +/**
> + * device_get_child_by_index - Return child using the provided index.
> + * @parent: parent struct device.
> + * @index:  Index of the child, where 0 is the first child in the children list,
> + * and so on.
> + *
> + * Returns child or NULL if child with this index is not present.
> + */
> +static struct device *
> +device_get_child_by_index(struct device *parent, int index)
> +{
> +       struct klist_iter i;
> +       struct device *dev = NULL, *d;
> +       int child_index = 0;
> +
> +       if (!parent->p || index < 0)
> +               return NULL;
> +
> +       klist_iter_init(&parent->p->klist_children, &i);
> +       while ((d = next_device(&i))) {
> +               if (child_index == index) {
> +                       dev = d;
> +                       break;
> +               }
> +               child_index++;
> +       }
> +       klist_iter_exit(&i);
> +
> +       return dev;
> +}

This can be implemented as a subfunction to device_find_child(), can't it be?

> +/**

Hmm... Why it's marked as kernel doc while it's just a plain comment?
Same applies to the rest of similar comments.

> + * Shutdown device tree with root started in dev. If dev has no children
> + * simply shutdown only this device. If dev has children recursively shutdown
> + * children first, and only then the parent. For performance reasons children
> + * are shutdown in parallel using kernel threads. because we lock dev its
> + * children cannot be removed while this functions is running.
> + */

> +static void device_shutdown_tree(struct device *dev)
> +{
> +       int children_count;
> +
> +       device_lock(dev);
> +       children_count = device_children_count(dev);
> +
> +       if (children_count) {
> +               struct device_shutdown_task_data tdata;
> +               int i;
> +
> +               init_completion(&tdata.complete);
> +               atomic_set(&tdata.child_next_index, 0);
> +               atomic_set(&tdata.tasks_running, children_count);
> +               tdata.parent = dev;
> +

> +               for (i = 0; i < children_count; i++) {
> +                       if (device_shutdown_serial) {
> +                               device_shutdown_child_task(&tdata);
> +                       } else {
> +                               kthread_run(device_shutdown_child_task,
> +                                           &tdata, "device_shutdown.%s",
> +                                           dev_name(dev));
> +                       }
> +               }

Can't we just use device_for_each_child() instead?

> +               wait_for_completion(&tdata.complete);
> +       }
> +       device_shutdown_one(dev);
> +       device_unlock(dev);
> +}

-- 
With Best Regards,
Andy Shevchenko
