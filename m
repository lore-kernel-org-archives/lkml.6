Return-Path: <ghartman@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523469008; cv=none;
        d=google.com; s=arc-20160816;
        b=cEkbAbDAj0UWDeDcEKqaCqyB/sGYwj45PopF1LZZwRv56Q2aNwEV3Bw8mVi5lZydvi
         BeRzeBRQYiJXgr6pRS9KI+8Yn4aBNHd6uB3F0dGoCcyvJhy6+TB+CwOfP4dlhTNpUtYA
         q9zWdW1JJjMK3cGNH0NobVXTAehR0BmEA43x+n7Vwuy8pwQ3PvKjHDn80oKnGkHUd04I
         BENbNAwrH58kVuFm75JTDUQ2SfTnJj3Vl01iNujvCgUN8hHImAHmOYMzbbx92iCi3Y85
         8A07c4/lrgc1h8UVPW0ORrpVXDjk7PEuTPUbiBkrR2gDsBnC/xiIOjgj6EIMug2Ex6ji
         xjYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=2TxAEEKhO5/0j/nx9iDBxUk1F7TPYVHi61tBCOfsQOY=;
        b=cOXUxTOZAAleo4eZp7v5rRR1XBYdO7/Xqd9lAyguu9yGLK5x8bTixpO+GgNaSby34R
         YjKkZjJHaenWSc2d7Ew6Rydmka+4M7abJvr0RRwlzguTs7l0Q7EUQSH3ATmuqxVafe8t
         TtqQjo6KlI/ffAEQyldHDulgnFwFhIo8852ENpJFX9/2NclM39djjtvzwy8lzaclMsqM
         t1OTShSJ2QjUDj3K+XSZYIzlIf/NAcERg6MVlKd5bohw+8ClHCCm+Pj0oJkMZgkyJRBA
         kadlepe/CQsHy8aba8jtWPGWU/kz4DwuCdQQ5yeRz622hr3HSF36AV/uvVOYLAtoTEA+
         oD8w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=VNDF8ccT;
       spf=pass (google.com: domain of ghartman@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ghartman@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=VNDF8ccT;
       spf=pass (google.com: domain of ghartman@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ghartman@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx48b8SBak5nR+7CdEKWh4sjIMeV56fG+HHbdPXGHwfISytwUlH0Z6hCE7Ae/XCcCpHQ9pYJulfQruIswZX3YF5A=
MIME-Version: 1.0
In-Reply-To: <20180411080536.sw6tesgi3vqgxxpn@mwanda>
References: <20180410190647.82986-1-astrachan@google.com> <20180411080536.sw6tesgi3vqgxxpn@mwanda>
From: Greg Hartman <ghartman@google.com>
Date: Wed, 11 Apr 2018 10:49:47 -0700
Message-ID: <CAOvepGkHgJwZs+LtLb+10yXUkLrRxazEJk3o2he-awhMV3WMMQ@mail.gmail.com>
Subject: Re: [PATCH] staging: Android: Add 'vsoc' driver for cuttlefish.
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alistair Strachan <astrachan@google.com>, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	maco@android.com, devel@driverdev.osuosl.org, kernel-team@android.com
Content-Type: multipart/alternative; boundary="001a1144273c0b66de0569964530"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597387330232855771?=
X-GMAIL-MSGID: =?utf-8?q?1597473039080437756?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a1144273c0b66de0569964530
Content-Type: text/plain; charset="UTF-8"

> +     /* Ensure that the offset is within shared memory */
> +     if (((uint64_t)arg->offset) + region_p->region_begin_offset +
> +         sizeof(uint32_t) > region_p->region_end_offset)

I'm not certain if I understand the overflow.

arg->offset, region_begin_offset, and region_end_offset are all uint32.

arg->offset is uint32, and is cast to uint_64_t. There is no sign
extension, so we known that the result is [0, 2^32)
adding region_begin_offset (also uint32) makes the result [0, 2^33)
adding sizeof(uint32_t) is unlikely to push the result above [0, 2^34)

region_end_offset is also uint32, but I'm fairly confident that the
comparison is well-formed.

Let me know if my reasoning is wrong on any of the above issues.

Either way, do you have suggestions for how to make this more idiomatic?

On Wed, Apr 11, 2018 at 1:05 AM, Dan Carpenter <dan.carpenter@oracle.com>
wrote:

> On Tue, Apr 10, 2018 at 12:06:47PM -0700, Alistair Strachan wrote:
> > +static int do_create_fd_scoped_permission(
> > +     struct vsoc_device_region *region_p,
> > +     struct fd_scoped_permission_node *np,
> > +     struct fd_scoped_permission_arg *__user arg)
> > +{
> > +     struct file *managed_filp;
> > +     s32 managed_fd;
> > +     atomic_t *owner_ptr = NULL;
> > +     struct vsoc_device_region *managed_region_p;
> > +
> > +     if (copy_from_user(&np->permission, &arg->perm, sizeof(*np)) ||
> > +         copy_from_user(&managed_fd,
> > +                        &arg->managed_region_fd, sizeof(managed_fd))) {
> > +             return -EFAULT;
> > +     }
> > +     managed_filp = fdget(managed_fd).file;
> > +     /* Check that it's a valid fd, */
> > +     if (!managed_filp || vsoc_validate_filep(managed_filp))
> > +             return -EPERM;
> > +     /* EEXIST if the given fd already has a permission. */
> > +     if (((struct vsoc_private_data *)managed_filp->private_data)->
> > +         fd_scoped_permission_node)
> > +             return -EEXIST;
> > +     managed_region_p = vsoc_region_from_filep(managed_filp);
> > +     /* Check that the provided region is managed by this one */
> > +     if (&vsoc_dev.regions[managed_region_p->managed_by] != region_p)
> > +             return -EPERM;
> > +     /* The area must be well formed and have non-zero size */
> > +     if (np->permission.begin_offset >= np->permission.end_offset)
> > +             return -EINVAL;
> > +     /* The area must fit in the memory window */
> > +     if (np->permission.end_offset >
> > +         vsoc_device_region_size(managed_region_p))
> > +             return -ERANGE;
> > +     /* The area must be in the region data section */
> > +     if (np->permission.begin_offset <
> > +         managed_region_p->offset_of_region_data)
> > +             return -ERANGE;
> > +     /* The area must be page aligned */
> > +     if (!PAGE_ALIGNED(np->permission.begin_offset) ||
> > +         !PAGE_ALIGNED(np->permission.end_offset))
> > +             return -EINVAL;
> > +     /* The owner flag must reside in the owner memory */
> > +     if (np->permission.owner_offset + sizeof(np->permission.owner_offset)
> >
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> ^^^^^
> There is a potential integer overflow here
>
> > +         vsoc_device_region_size(region_p))
> > +             return -ERANGE;
> > +     /* The owner flag must reside in the data section */
> > +     if (np->permission.owner_offset < region_p->offset_of_region_data)
> > +             return -EINVAL;
> > +     /* Owner offset must be naturally aligned in the window */
> > +     if (np->permission.owner_offset &
> > +         (sizeof(np->permission.owner_offset) - 1))
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> but then we prevent it here so that's fine.  But it would be better to
> reverse these checks so that it's easier to review.
>
> > +             return -EINVAL;
> > +     /* The owner value must change to claim the memory */
> > +     if (np->permission.owned_value == VSOC_REGION_FREE)
> > +             return -EINVAL;
> > +     owner_ptr =
> > +         (atomic_t *)shm_off_to_virtual_addr(region_p->region_begin_offset
> +
> > +
>  np->permission.owner_offset);
> > +     /* We've already verified that this is in the shared memory
> window, so
> > +      * it should be safe to write to this address.
> > +      */
> > +     if (atomic_cmpxchg(owner_ptr,
> > +                        VSOC_REGION_FREE,
> > +                        np->permission.owned_value) !=
> VSOC_REGION_FREE) {
> > +             return -EBUSY;
> > +     }
> > +     ((struct vsoc_private_data *)managed_filp->private_data)->
> > +         fd_scoped_permission_node = np;
> > +     /* The file offset needs to be adjusted if the calling
> > +      * process did any read/write operations on the fd
> > +      * before creating the permission.
> > +      */
> > +     if (managed_filp->f_pos) {
> > +             if (managed_filp->f_pos > np->permission.end_offset) {
> > +                     /* If the offset is beyond the permission end, set
> it
> > +                      * to the end.
> > +                      */
> > +                     managed_filp->f_pos = np->permission.end_offset;
> > +             } else {
> > +                     /* If the offset is within the permission interval
> > +                      * keep it there otherwise reset it to zero.
> > +                      */
> > +                     if (managed_filp->f_pos <
> np->permission.begin_offset) {
> > +                             managed_filp->f_pos = 0;
> > +                     } else {
> > +                             managed_filp->f_pos -=
> > +                                 np->permission.begin_offset;
> > +                     }
> > +             }
> > +     }
> > +     return 0;
> > +}
> > +
>
> [ snip ]
>
> > +
> > +/**
> > + * Implements the inner logic of cond_wait. Copies to and from
> userspace are
> > + * done in the helper function below.
> > + */
> > +static int handle_vsoc_cond_wait(struct file *filp, struct
> vsoc_cond_wait *arg)
> > +{
> > +     DEFINE_WAIT(wait);
> > +     u32 region_number = iminor(file_inode(filp));
> > +     struct vsoc_region_data *data = vsoc_dev.regions_data +
> region_number;
> > +     struct hrtimer_sleeper timeout, *to = NULL;
> > +     int ret = 0;
> > +     struct vsoc_device_region *region_p = vsoc_region_from_filep(filp);
> > +     atomic_t *address = NULL;
> > +     struct timespec ts;
> > +
> > +     /* Ensure that the offset is aligned */
> > +     if (arg->offset & (sizeof(uint32_t) - 1))
> > +             return -EADDRNOTAVAIL;
> > +     /* Ensure that the offset is within shared memory */
> > +     if (((uint64_t)arg->offset) + region_p->region_begin_offset +
> > +         sizeof(uint32_t) > region_p->region_end_offset)
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This could overflow.
>
> > +             return -E2BIG;
> > +     address = shm_off_to_virtual_addr(region_p->region_begin_offset +
> > +                                       arg->offset);
> > +
> > +     /* Ensure that the type of wait is valid */
> > +     switch (arg->wait_type) {
> > +     case VSOC_WAIT_IF_EQUAL:
> > +             break;
> > +     case VSOC_WAIT_IF_EQUAL_TIMEOUT:
> > +             to = &timeout;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (to) {
> > +             /* Copy the user-supplied timesec into the kernel
> structure.
> > +              * We do things this way to flatten differences between 32
> bit
> > +              * and 64 bit timespecs.
> > +              */
> > +             ts.tv_sec = arg->wake_time_sec;
> > +             ts.tv_nsec = arg->wake_time_nsec;
> > +
> > +             if (!timespec_valid(&ts))
> > +                     return -EINVAL;
> > +             hrtimer_init_on_stack(&to->timer, CLOCK_MONOTONIC,
> > +                                   HRTIMER_MODE_ABS);
> > +             hrtimer_set_expires_range_ns(&to->timer,
> timespec_to_ktime(ts),
> > +                                          current->timer_slack_ns);
> > +
> > +             hrtimer_init_sleeper(to, current);
> > +     }
> > +
> > +     while (1) {
> > +             prepare_to_wait(&data->futex_wait_queue, &wait,
> > +                             TASK_INTERRUPTIBLE);
> > +             /*
> > +              * Check the sentinel value after prepare_to_wait. If the
> value
> > +              * changes after this check the writer will call signal,
> > +              * changing the task state from INTERRUPTIBLE to RUNNING.
> That
> > +              * will ensure that schedule() will eventually schedule
> this
> > +              * task.
> > +              */
> > +             if (atomic_read(address) != arg->value) {
> > +                     ret = 0;
> > +                     break;
> > +             }
> > +             if (to) {
> > +                     hrtimer_start_expires(&to->timer,
> HRTIMER_MODE_ABS);
> > +                     if (likely(to->task))
> > +                             freezable_schedule();
> > +                     hrtimer_cancel(&to->timer);
> > +                     if (!to->task) {
> > +                             ret = -ETIMEDOUT;
> > +                             break;
> > +                     }
> > +             } else {
> > +                     freezable_schedule();
> > +             }
> > +             /* Count the number of times that we woke up. This is
> useful
> > +              * for unit testing.
> > +              */
> > +             ++arg->wakes;
> > +             if (signal_pending(current)) {
> > +                     ret = -EINTR;
> > +                     break;
> > +             }
> > +     }
> > +     finish_wait(&data->futex_wait_queue, &wait);
> > +     if (to)
> > +             destroy_hrtimer_on_stack(&to->timer);
> > +     return ret;
> > +}
> > +
>
> [ snip ]
>
> > +
> > +static int vsoc_probe_device(struct pci_dev *pdev,
> > +                          const struct pci_device_id *ent)
> > +{
> > +     int result;
> > +     int i;
> > +     resource_size_t reg_size;
> > +     dev_t devt;
> > +
> > +     vsoc_dev.dev = pdev;
> > +     result = pci_enable_device(pdev);
> > +     if (result) {
> > +             dev_err(&pdev->dev,
> > +                     "pci_enable_device failed %s: error %d\n",
> > +                     pci_name(pdev), result);
> > +             return result;
> > +     }
> > +     vsoc_dev.enabled_device = 1;
> > +     result = pci_request_regions(pdev, "vsoc");
> > +     if (result < 0) {
> > +             dev_err(&pdev->dev, "pci_request_regions failed\n");
> > +             vsoc_remove_device(pdev);
> > +             return -EBUSY;
> > +     }
> > +     vsoc_dev.requested_regions = 1;
> > +     /* Set up the control registers in BAR 0 */
> > +     reg_size = pci_resource_len(pdev, REGISTER_BAR);
> > +     if (reg_size > MAX_REGISTER_BAR_LEN)
> > +             vsoc_dev.regs =
> > +                 pci_iomap(pdev, REGISTER_BAR, MAX_REGISTER_BAR_LEN);
> > +     else
> > +             vsoc_dev.regs = pci_iomap(pdev, REGISTER_BAR, reg_size);
> > +
> > +     if (!vsoc_dev.regs) {
> > +             dev_err(&pdev->dev,
> > +                     "cannot ioremap registers of size %zu\n",
> > +                    (size_t)reg_size);
> > +             vsoc_remove_device(pdev);
> > +             return -EBUSY;
> > +     }
> > +
> > +     /* Map the shared memory in BAR 2 */
> > +     vsoc_dev.shm_phys_start = pci_resource_start(pdev,
> SHARED_MEMORY_BAR);
> > +     vsoc_dev.shm_size = pci_resource_len(pdev, SHARED_MEMORY_BAR);
> > +
> > +     dev_info(&pdev->dev, "shared memory @ DMA %p size=0x%zx\n",
> > +              (void *)vsoc_dev.shm_phys_start, vsoc_dev.shm_size);
> > +     /* TODO(ghartman): ioremap_wc should work here */
> > +     vsoc_dev.kernel_mapped_shm = ioremap_nocache(
> > +                     vsoc_dev.shm_phys_start, vsoc_dev.shm_size);
> > +     if (!vsoc_dev.kernel_mapped_shm) {
> > +             dev_err(&vsoc_dev.dev->dev, "cannot iomap region\n");
> > +             vsoc_remove_device(pdev);
> > +             return -EBUSY;
> > +     }
> > +
> > +     vsoc_dev.layout =
> > +         (struct vsoc_shm_layout_descriptor
> *)vsoc_dev.kernel_mapped_shm;
> > +     dev_info(&pdev->dev, "major_version: %d\n",
> > +              vsoc_dev.layout->major_version);
> > +     dev_info(&pdev->dev, "minor_version: %d\n",
> > +              vsoc_dev.layout->minor_version);
> > +     dev_info(&pdev->dev, "size: 0x%x\n", vsoc_dev.layout->size);
> > +     dev_info(&pdev->dev, "regions: %d\n",
> vsoc_dev.layout->region_count);
> > +     if (vsoc_dev.layout->major_version !=
> > +         CURRENT_VSOC_LAYOUT_MAJOR_VERSION) {
> > +             dev_err(&vsoc_dev.dev->dev,
> > +                     "driver supports only major_version %d\n",
> > +                     CURRENT_VSOC_LAYOUT_MAJOR_VERSION);
> > +             vsoc_remove_device(pdev);
> > +             return -EBUSY;
> > +     }
> > +     result = alloc_chrdev_region(&devt, 0,
> vsoc_dev.layout->region_count,
> > +                                  VSOC_DEV_NAME);
> > +     if (result) {
> > +             dev_err(&vsoc_dev.dev->dev, "alloc_chrdev_region
> failed\n");
> > +             vsoc_remove_device(pdev);
> > +             return -EBUSY;
> > +     }
> > +     vsoc_dev.major = MAJOR(devt);
> > +     cdev_init(&vsoc_dev.cdev, &vsoc_ops);
> > +     vsoc_dev.cdev.owner = THIS_MODULE;
> > +     result = cdev_add(&vsoc_dev.cdev, devt,
> vsoc_dev.layout->region_count);
> > +     if (result) {
> > +             dev_err(&vsoc_dev.dev->dev, "cdev_add error\n");
> > +             vsoc_remove_device(pdev);
> > +             return -EBUSY;
> > +     }
> > +     vsoc_dev.cdev_added = 1;
> > +     vsoc_dev.class = class_create(THIS_MODULE, VSOC_DEV_NAME);
> > +     if (!vsoc_dev.class) {
>             ^^^^^^^^^^^^^^^
> This should be if (IS_ERR(vsoc_dev.class)) {.  The test in
> vsoc_remove_device() needs to be updated as well.
>
> > +             dev_err(&vsoc_dev.dev->dev, "class_create failed\n");
> > +             vsoc_remove_device(pdev);
> > +             return -EBUSY;
> > +     }
> > +     vsoc_dev.regions = (struct vsoc_device_region *)
> > +             (vsoc_dev.kernel_mapped_shm +
> > +              vsoc_dev.layout->vsoc_region_desc_offset);
> > +     vsoc_dev.msix_entries = kcalloc(
> > +                     vsoc_dev.layout->region_count,
> > +                     sizeof(vsoc_dev.msix_entries[0]), GFP_KERNEL);
> > +     if (!vsoc_dev.msix_entries) {
> > +             dev_err(&vsoc_dev.dev->dev,
> > +                     "unable to allocate msix_entries\n");
> > +             vsoc_remove_device(pdev);
> > +             return -ENOSPC;
> > +     }
> > +     vsoc_dev.regions_data = kcalloc(
> > +                     vsoc_dev.layout->region_count,
> > +                     sizeof(vsoc_dev.regions_data[0]), GFP_KERNEL);
> > +     if (!vsoc_dev.regions_data) {
> > +             dev_err(&vsoc_dev.dev->dev,
> > +                     "unable to allocate regions' data\n");
> > +             vsoc_remove_device(pdev);
> > +             return -ENOSPC;
> > +     }
> > +     for (i = 0; i < vsoc_dev.layout->region_count; ++i)
> > +             vsoc_dev.msix_entries[i].entry = i;
> > +
> > +     result = pci_enable_msix_exact(vsoc_dev.dev,
> vsoc_dev.msix_entries,
> > +                                    vsoc_dev.layout->region_count);
> > +     if (result) {
> > +             dev_info(&pdev->dev, "pci_enable_msix failed: %d\n",
> result);
> > +             vsoc_remove_device(pdev);
> > +             return -ENOSPC;
> > +     }
> > +     /* Check that all regions are well formed */
> > +     for (i = 0; i < vsoc_dev.layout->region_count; ++i) {
> > +             const struct vsoc_device_region *region = vsoc_dev.regions
> + i;
> > +
> > +             if (!PAGE_ALIGNED(region->region_begin_offset) ||
> > +                 !PAGE_ALIGNED(region->region_end_offset)) {
> > +                     dev_err(&vsoc_dev.dev->dev,
> > +                             "region %d not aligned (%x:%x)", i,
> > +                             region->region_begin_offset,
> > +                             region->region_end_offset);
> > +                     vsoc_remove_device(pdev);
> > +                     return -EFAULT;
> > +             }
> > +             if (region->region_begin_offset >=
> region->region_end_offset ||
> > +                 region->region_end_offset > vsoc_dev.shm_size) {
> > +                     dev_err(&vsoc_dev.dev->dev,
> > +                             "region %d offsets are wrong: %x %x %zx",
> > +                             i, region->region_begin_offset,
> > +                             region->region_end_offset,
> vsoc_dev.shm_size);
> > +                     vsoc_remove_device(pdev);
> > +                     return -EFAULT;
> > +             }
> > +             if (region->managed_by >= vsoc_dev.layout->region_count) {
> > +                     dev_err(&vsoc_dev.dev->dev,
> > +                             "region %d has invalid owner: %u",
> > +                             i, region->managed_by);
> > +                     vsoc_remove_device(pdev);
> > +                     return -EFAULT;
> > +             }
> > +     }
> > +     vsoc_dev.msix_enabled = 1;
> > +     for (i = 0; i < vsoc_dev.layout->region_count; ++i) {
> > +             const struct vsoc_device_region *region = vsoc_dev.regions
> + i;
> > +             size_t name_sz = sizeof(vsoc_dev.regions_data[i].name) -
> 1;
> > +             const struct vsoc_signal_table_layout *h_to_g_signal_table
> =
> > +                     &region->host_to_guest_signal_table;
> > +             const struct vsoc_signal_table_layout *g_to_h_signal_table
> =
> > +                     &region->guest_to_host_signal_table;
> > +
> > +             vsoc_dev.regions_data[i].name[name_sz] = '\0';
> > +             memcpy(vsoc_dev.regions_data[i].name, region->device_name,
> > +                    name_sz);
> > +             dev_info(&pdev->dev, "region %d name=%s\n",
> > +                      i, vsoc_dev.regions_data[i].name);
> > +             init_waitqueue_head(
> > +                             &vsoc_dev.regions_data[i].
> interrupt_wait_queue);
> > +             init_waitqueue_head(&vsoc_dev.regions_data[i].futex_wait_
> queue);
> > +             vsoc_dev.regions_data[i].incoming_signalled =
> > +                     vsoc_dev.kernel_mapped_shm +
> > +                     region->region_begin_offset +
> > +                     h_to_g_signal_table->interrupt_signalled_offset;
> > +             vsoc_dev.regions_data[i].outgoing_signalled =
> > +                     vsoc_dev.kernel_mapped_shm +
> > +                     region->region_begin_offset +
> > +                     g_to_h_signal_table->interrupt_signalled_offset;
> > +
> > +             result = request_irq(
> > +                             vsoc_dev.msix_entries[i].vector,
> > +                             vsoc_interrupt, 0,
> > +                             vsoc_dev.regions_data[i].name,
> > +                             vsoc_dev.regions_data + i);
> > +             if (result) {
> > +                     dev_info(&pdev->dev,
> > +                              "request_irq failed irq=%d vector=%d\n",
> > +                             i, vsoc_dev.msix_entries[i].vector);
> > +                     vsoc_remove_device(pdev);
> > +                     return -ENOSPC;
> > +             }
> > +             vsoc_dev.regions_data[i].irq_requested = 1;
> > +             if (!device_create(vsoc_dev.class, NULL,
> > +                                MKDEV(vsoc_dev.major, i),
> > +                                NULL, vsoc_dev.regions_data[i].name)) {
> > +                     dev_err(&vsoc_dev.dev->dev, "device_create
> failed\n");
> > +                     vsoc_remove_device(pdev);
> > +                     return -EBUSY;
> > +             }
> > +             vsoc_dev.regions_data[i].device_created = 1;
> > +     }
> > +     return 0;
> > +}
> > +
> > +/*
> > + * This should undo all of the allocations in the probe function in
> reverse
> > + * order.
> > + *
> > + * Notes:
> > + *
> > + *   The device may have been partially initialized, so double check
> > + *   that the allocations happened.
> > + *
> > + *   This function may be called multiple times, so mark resources as
> freed
> > + *   as they are deallocated.
> > + */
> > +static void vsoc_remove_device(struct pci_dev *pdev)
> > +{
> > +     int i;
> > +     /*
> > +      * pdev is the first thing to be set on probe and the last thing
> > +      * to be cleared here. If it's NULL then there is no cleanup.
> > +      */
> > +     if (!pdev || !vsoc_dev.dev)
> > +             return;
> > +     dev_info(&pdev->dev, "remove_device\n");
> > +     if (vsoc_dev.regions_data) {
> > +             for (i = 0; i < vsoc_dev.layout->region_count; ++i) {
> > +                     if (vsoc_dev.regions_data[i].device_created) {
> > +                             device_destroy(vsoc_dev.class,
> > +                                            MKDEV(vsoc_dev.major, i));
> > +                             vsoc_dev.regions_data[i].device_created =
> 0;
> > +                     }
> > +                     if (vsoc_dev.regions_data[i].irq_requested)
> > +                             free_irq(vsoc_dev.msix_entries[i].vector,
> NULL);
> > +                     vsoc_dev.regions_data[i].irq_requested = 0;
> > +             }
> > +             kfree(vsoc_dev.regions_data);
> > +             vsoc_dev.regions_data = 0;
> > +     }
> > +     if (vsoc_dev.msix_enabled) {
> > +             pci_disable_msix(pdev);
> > +             vsoc_dev.msix_enabled = 0;
> > +     }
> > +     kfree(vsoc_dev.msix_entries);
> > +     vsoc_dev.msix_entries = 0;
> > +     vsoc_dev.regions = 0;
> > +     if (vsoc_dev.class) {
> > +             class_destroy(vsoc_dev.class);
> > +             vsoc_dev.class = 0;
> > +     }
> > +     if (vsoc_dev.cdev_added) {
> > +             cdev_del(&vsoc_dev.cdev);
> > +             vsoc_dev.cdev_added = 0;
> > +     }
> > +     if (vsoc_dev.major && vsoc_dev.layout) {
> > +             unregister_chrdev_region(MKDEV(vsoc_dev.major, 0),
> > +                                      vsoc_dev.layout->region_count);
> > +             vsoc_dev.major = 0;
> > +     }
> > +     vsoc_dev.layout = 0;
> > +     if (vsoc_dev.kernel_mapped_shm && pdev) {
>                                           ^^^^
> These tests can be removed since we checked at the start of the function.
>
> > +             pci_iounmap(pdev, vsoc_dev.kernel_mapped_shm);
> > +             vsoc_dev.kernel_mapped_shm = 0;
> > +     }
> > +     if (vsoc_dev.regs && pdev) {
>                              ^^^^
> > +             pci_iounmap(pdev, vsoc_dev.regs);
> > +             vsoc_dev.regs = 0;
> > +     }
> > +     if (vsoc_dev.requested_regions && pdev) {
>                                           ^^^^
> > +             pci_release_regions(pdev);
> > +             vsoc_dev.requested_regions = 0;
> > +     }
> > +     if (vsoc_dev.enabled_device && pdev) {
>                                        ^^^^
> > +             pci_disable_device(pdev);
> > +             vsoc_dev.enabled_device = 0;
> > +     }
> > +     /* Do this last: it indicates that the device is not initialized.
> */
> > +     vsoc_dev.dev = NULL;
> > +}
> > +
>
> regards,
> dan carpenter
>
>

--001a1144273c0b66de0569964530
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>&gt; +=C2=A0 =C2=A0 =C2=A0/* Ensure that the offset i=
s within shared memory */</div><div>&gt; +=C2=A0 =C2=A0 =C2=A0if (((uint64_=
t)arg-&gt;offset) + region_p-&gt;region_begin_offset +</div><div>&gt; +=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(uint32_t) &gt; region_p-&gt;region_en=
d_offset)</div><div>=C2=A0</div><div>I&#39;m not certain if I understand th=
e overflow.</div><div><br></div><div>arg-&gt;offset, region_begin_offset, a=
nd region_end_offset are all uint32.</div><div><br></div><div>arg-&gt;offse=
t is uint32, and is cast to uint_64_t. There is no sign extension, so we kn=
own that the result is [0, 2^32)</div><div>adding region_begin_offset (also=
 uint32) makes the result=C2=A0<span style=3D"color:rgb(34,34,34);font-fami=
ly:arial,sans-serif;font-size:small;font-style:normal;font-variant-ligature=
s:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;=
text-decoration-color:initial;float:none;display:inline">[0, 2^33)</span></=
div><div><span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;fo=
nt-size:small;font-style:normal;font-variant-ligatures:normal;font-variant-=
caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;white-space:normal;word-spacing:0px;background-=
color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:=
initial;float:none;display:inline">adding sizeof(uint32_t) is unlikely to p=
ush the result above [0, 2^34)</span></div><div><span style=3D"color:rgb(34=
,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorati=
on-style:initial;text-decoration-color:initial;float:none;display:inline"><=
br></span></div><div><span style=3D"color:rgb(34,34,34);font-family:arial,s=
ans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;f=
ont-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px=
;background-color:rgb(255,255,255);text-decoration-style:initial;text-decor=
ation-color:initial;float:none;display:inline">region_end_offset is also ui=
nt32, but I&#39;m fairly confident that the comparison is well-formed.</spa=
n><br></div><div><span style=3D"color:rgb(34,34,34);font-family:arial,sans-=
serif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-=
variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;=
text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;bac=
kground-color:rgb(255,255,255);text-decoration-style:initial;text-decoratio=
n-color:initial;float:none;display:inline"><br></span></div><div><span styl=
e=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-=
style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-we=
ight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transf=
orm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,2=
55);text-decoration-style:initial;text-decoration-color:initial;float:none;=
display:inline">Let me know if my reasoning is wrong on any of the above is=
sues.</span></div><div><span style=3D"color:rgb(34,34,34);font-family:arial=
,sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal=
;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:=
start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0=
px;background-color:rgb(255,255,255);text-decoration-style:initial;text-dec=
oration-color:initial;float:none;display:inline"><br></span></div><div><spa=
n style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small=
;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;f=
ont-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255=
,255,255);text-decoration-style:initial;text-decoration-color:initial;float=
:none;display:inline">Either way, do you have suggestions for how to make t=
his more idiomatic?</span></div></div><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote">On Wed, Apr 11, 2018 at 1:05 AM, Dan Carpenter <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:dan.carpenter@oracle.com" target=3D"_blank=
">dan.carpenter@oracle.com</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On Tue, Apr 10, 2018 at 12:=
06:47PM -0700, Alistair Strachan wrote:<br>
&gt; +static int do_create_fd_scoped_<wbr>permission(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct vsoc_device_region *region_p,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct fd_scoped_permission_node *np,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct fd_scoped_permission_arg *__user arg)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct file *managed_filp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0s32 managed_fd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0atomic_t *owner_ptr =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct vsoc_device_region *managed_region_p;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (copy_from_user(&amp;np-&gt;<wbr>permission, &=
amp;arg-&gt;perm, sizeof(*np)) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0copy_from_user(&amp;managed_fd,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &amp;arg-&gt;managed_region_fd, sizeof(managed_fd))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0managed_filp =3D fdget(managed_fd).file;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Check that it&#39;s a valid fd, */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!managed_filp || vsoc_validate_filep(managed_=
<wbr>filp))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EPERM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* EEXIST if the given fd already has a permissio=
n. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (((struct vsoc_private_data *)managed_filp-&gt=
;private_data)-<wbr>&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd_scoped_permission_node)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EEXIST;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0managed_region_p =3D vsoc_region_from_filep(<wbr>=
managed_filp);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Check that the provided region is managed by t=
his one */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (&amp;vsoc_dev.regions[managed_<wbr>region_p-&=
gt;managed_by] !=3D region_p)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EPERM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* The area must be well formed and have non-zero=
 size */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (np-&gt;permission.begin_offset &gt;=3D np-&gt=
;permission.end_offset)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* The area must fit in the memory window */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (np-&gt;permission.end_offset &gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_device_region_size(<wbr>manage=
d_region_p))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ERANGE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* The area must be in the region data section */=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (np-&gt;permission.begin_offset &lt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0managed_region_p-&gt;offset_of_<wbr=
>region_data)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ERANGE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* The area must be page aligned */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!PAGE_ALIGNED(np-&gt;permission.<wbr>begin_of=
fset) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!PAGE_ALIGNED(np-&gt;permission.<wb=
r>end_offset))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* The owner flag must reside in the owner memory=
 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (np-&gt;permission.owner_offset + sizeof(np-&g=
t;permission.owner_<wbr>offset) &gt;<br>
</div></div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^<wbr>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<wbr>^^^^^<br>
There is a potential integer overflow here<br>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_device_region_size(<wbr>region=
_p))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ERANGE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* The owner flag must reside in the data section=
 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (np-&gt;permission.owner_offset &lt; region_p-=
&gt;offset_of_region_<wbr>data)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Owner offset must be naturally aligned in the =
window */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (np-&gt;permission.owner_offset &amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(sizeof(np-&gt;permission.owner_<wb=
r>offset) - 1))<br>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^<wbr>^^^^^^^^^^^<br>
but then we prevent it here so that&#39;s fine.=C2=A0 But it would be bette=
r to<br>
reverse these checks so that it&#39;s easier to review.<br>
<div><div class=3D"h5"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* The owner value must change to claim the memor=
y */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (np-&gt;permission.owned_value =3D=3D VSOC_REG=
ION_FREE)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0owner_ptr =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(atomic_t *)shm_off_to_virtual_addr=
(<wbr>region_p-&gt;region_begin_offset +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0np-&gt;permission.owner_offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* We&#39;ve already verified that this is in the=
 shared memory window, so<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * it should be safe to write to this address.<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (atomic_cmpxchg(owner_ptr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 VSOC_REGION_FREE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 np-&gt;permission.owned_value) !=3D VSOC_REGION_FREE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EBUSY;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0((struct vsoc_private_data *)managed_filp-&gt;pri=
vate_data)-<wbr>&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd_scoped_permission_node =3D np;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0/* The file offset needs to be adjusted if the ca=
lling<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * process did any read/write operations on the f=
d<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * before creating the permission.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (managed_filp-&gt;f_pos) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (managed_filp-&gt;=
f_pos &gt; np-&gt;permission.end_offset) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* If the offset is beyond the permission end, set it<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 * to the end.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0managed_filp-&gt;f_pos =3D np-&gt;permission.end_offset;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* If the offset is within the permission interval<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 * keep it there otherwise reset it to zero.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (managed_filp-&gt;f_pos &lt; np-&gt;permission.begin_offset) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0managed_filp-&gt;f_pos =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0managed_filp-&gt;f_pos -=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0np-&gt;permission.begin_of=
fset;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
<br>
</div></div>[ snip ]<br>
<span class=3D""><br>
&gt; +<br>
&gt; +/**<br>
&gt; + * Implements the inner logic of cond_wait. Copies to and from usersp=
ace are<br>
&gt; + * done in the helper function below.<br>
&gt; + */<br>
&gt; +static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_=
wait *arg)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0DEFINE_WAIT(wait);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 region_number =3D iminor(file_inode(filp));<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0struct vsoc_region_data *data =3D vsoc_dev.region=
s_data + region_number;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct hrtimer_sleeper timeout, *to =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct vsoc_device_region *region_p =3D vsoc_regi=
on_from_filep(filp);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0atomic_t *address =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct timespec ts;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Ensure that the offset is aligned */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (arg-&gt;offset &amp; (sizeof(uint32_t) - 1))<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EADDRNOTAVAIL=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Ensure that the offset is within shared memory=
 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (((uint64_t)arg-&gt;offset) + region_p-&gt;reg=
ion_begin_offset +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(uint32_t) &gt; region_p-&gt;=
region_end_offset)<br>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^<wbr>^^^^^^^^^^^^^^^^<br>
This could overflow.<br>
<div><div class=3D"h5"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -E2BIG;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0address =3D shm_off_to_virtual_addr(<wbr>region_p=
-&gt;region_begin_offset +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arg-&=
gt;offset);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Ensure that the type of wait is valid */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0switch (arg-&gt;wait_type) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case VSOC_WAIT_IF_EQUAL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case VSOC_WAIT_IF_EQUAL_TIMEOUT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to =3D &amp;timeout;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (to) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Copy the user-supp=
lied timesec into the kernel structure.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * We do things this =
way to flatten differences between 32 bit<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * and 64 bit timespe=
cs.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ts.tv_sec =3D arg-&gt=
;wake_time_sec;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ts.tv_nsec =3D arg-&g=
t;wake_time_nsec;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!timespec_valid(&=
amp;ts))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hrtimer_init_on_stack=
(&amp;to-&gt;<wbr>timer, CLOCK_MONOTONIC,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HRTIMER_MODE_ABS);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hrtimer_set_expires_r=
ange_ns(&amp;<wbr>to-&gt;timer, timespec_to_ktime(ts),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 current-&gt;timer_slack_ns);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hrtimer_init_sleeper(=
to, current);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0while (1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prepare_to_wait(&amp;=
data-&gt;futex_<wbr>wait_queue, &amp;wait,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TASK_INTERRUPTIBLE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Check the sentinel=
 value after prepare_to_wait. If the value<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * changes after this=
 check the writer will call signal,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * changing the task =
state from INTERRUPTIBLE to RUNNING. That<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * will ensure that s=
chedule() will eventually schedule this<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * task.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (atomic_read(addre=
ss) !=3D arg-&gt;value) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ret =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (to) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0hrtimer_start_expires(&amp;to-&gt;<wbr>timer, HRTIMER_MODE_ABS);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (likely(to-&gt;task))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0freezable_schedule();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0hrtimer_cancel(&amp;to-&gt;timer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (!to-&gt;task) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -ETIMEDOUT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0freezable_schedule();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Count the number o=
f times that we woke up. This is useful<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * for unit testing.<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0++arg-&gt;wakes;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (signal_pending(cu=
rrent)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ret =3D -EINTR;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0finish_wait(&amp;data-&gt;futex_wait_<wbr>queue, =
&amp;wait);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (to)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0destroy_hrtimer_on_st=
ack(&amp;to-&gt;<wbr>timer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
<br>
</div></div>[ snip ]<br>
<div><div class=3D"h5"><br>
&gt; +<br>
&gt; +static int vsoc_probe_device(struct pci_dev *pdev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 const struct pci_device_id *ent)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int result;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0resource_size_t reg_size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dev_t devt;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vsoc_dev.dev =3D pdev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0result =3D pci_enable_device(pdev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (result) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&gt=
;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;pci_enable_device failed %s: error %d\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pci_name(pdev), result);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return result;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vsoc_dev.enabled_device =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0result =3D pci_request_regions(pdev, &quot;vsoc&q=
uot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (result &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&gt=
;dev, &quot;pci_request_regions failed\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_remove_device(pd=
ev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EBUSY;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vsoc_dev.requested_regions =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Set up the control registers in BAR 0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0reg_size =3D pci_resource_len(pdev, REGISTER_BAR)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (reg_size &gt; MAX_REGISTER_BAR_LEN)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.regs =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_iom=
ap(pdev, REGISTER_BAR, MAX_REGISTER_BAR_LEN);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.regs =3D pci=
_iomap(pdev, REGISTER_BAR, reg_size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!vsoc_dev.regs) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&gt=
;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;cannot ioremap registers of size %zu\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (size_t)reg_size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_remove_device(pd=
ev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EBUSY;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Map the shared memory in BAR 2 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vsoc_dev.shm_phys_start =3D pci_resource_start(pd=
ev, SHARED_MEMORY_BAR);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vsoc_dev.shm_size =3D pci_resource_len(pdev, SHAR=
ED_MEMORY_BAR);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dev_info(&amp;pdev-&gt;dev, &quot;shared memory @=
 DMA %p size=3D0x%zx\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (void *)vsoc_dev.shm=
_phys_start, vsoc_dev.shm_size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* TODO(ghartman): ioremap_wc should work here */=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vsoc_dev.kernel_mapped_shm =3D ioremap_nocache(<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vsoc_dev.shm_phys_start, vsoc_dev.shm_size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!vsoc_dev.kernel_mapped_shm) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;vsoc_dev=
.dev-&gt;dev, &quot;cannot iomap region\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_remove_device(pd=
ev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EBUSY;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vsoc_dev.layout =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(struct vsoc_shm_layout_descriptor =
*)vsoc_dev.kernel_mapped_shm;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dev_info(&amp;pdev-&gt;dev, &quot;major_version: =
%d\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vsoc_dev.layout-&gt;=
major_<wbr>version);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dev_info(&amp;pdev-&gt;dev, &quot;minor_version: =
%d\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vsoc_dev.layout-&gt;=
minor_<wbr>version);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dev_info(&amp;pdev-&gt;dev, &quot;size: 0x%x\n&qu=
ot;, vsoc_dev.layout-&gt;size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dev_info(&amp;pdev-&gt;dev, &quot;regions: %d\n&q=
uot;, vsoc_dev.layout-&gt;region_count)<wbr>;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (vsoc_dev.layout-&gt;major_<wbr>version !=3D<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CURRENT_VSOC_LAYOUT_MAJOR_<wbr>VERS=
ION) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;vsoc_dev=
.dev-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;driver supports only major_version %d\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0CURRENT_VSOC_LAYOUT_MAJOR_<wbr>VERSION);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_remove_device(pd=
ev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EBUSY;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0result =3D alloc_chrdev_region(&amp;devt, 0, vsoc=
_dev.layout-&gt;region_count,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VSOC_DEV_NAME);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (result) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;vsoc_dev=
.dev-&gt;dev, &quot;alloc_chrdev_region failed\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_remove_device(pd=
ev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EBUSY;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vsoc_dev.major =3D MAJOR(devt);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cdev_init(&amp;vsoc_dev.cdev, &amp;vsoc_ops);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vsoc_dev.cdev.owner =3D THIS_MODULE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0result =3D cdev_add(&amp;vsoc_dev.cdev, devt, vso=
c_dev.layout-&gt;region_count)<wbr>;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (result) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;vsoc_dev=
.dev-&gt;dev, &quot;cdev_add error\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_remove_device(pd=
ev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EBUSY;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vsoc_dev.cdev_added =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vsoc_dev.class =3D class_create(THIS_MODULE, VSOC=
_DEV_NAME);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!vsoc_dev.class) {<br>
</div></div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^^^^^^^^^^^^^^^<br>
This should be if (IS_ERR(vsoc_dev.class)) {.=C2=A0 The test in<br>
vsoc_remove_device() needs to be updated as well.<br>
<div><div class=3D"h5"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;vsoc_dev=
.dev-&gt;dev, &quot;class_create failed\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_remove_device(pd=
ev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EBUSY;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vsoc_dev.regions =3D (struct vsoc_device_region *=
)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(vsoc_dev.kernel_mapp=
ed_shm +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vsoc_dev.layout-&gt;=
vsoc_region_<wbr>desc_offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vsoc_dev.msix_entries =3D kcalloc(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vsoc_dev.layout-&gt;region_count,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0sizeof(vsoc_dev.msix_entries[<wbr>0]), GFP_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!vsoc_dev.msix_entries) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;vsoc_dev=
.dev-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;unable to allocate msix_entries\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_remove_device(pd=
ev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOSPC;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vsoc_dev.regions_data =3D kcalloc(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vsoc_dev.layout-&gt;region_count,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0sizeof(vsoc_dev.regions_data[<wbr>0]), GFP_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!vsoc_dev.regions_data) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;vsoc_dev=
.dev-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;unable to allocate regions&#39; data\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_remove_device(pd=
ev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOSPC;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; vsoc_dev.layout-&gt;region_c=
ount; ++i)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.msix_entries=
[i].entry =3D i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0result =3D pci_enable_msix_exact(vsoc_<wbr>dev.de=
v, vsoc_dev.msix_entries,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vsoc_dev.layout-&g=
t;region_count)<wbr>;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (result) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(&amp;pdev-&g=
t;dev, &quot;pci_enable_msix failed: %d\n&quot;, result);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_remove_device(pd=
ev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOSPC;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Check that all regions are well formed */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; vsoc_dev.layout-&gt;region_c=
ount; ++i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct vsoc_dev=
ice_region *region =3D vsoc_dev.regions + i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!PAGE_ALIGNED(reg=
ion-&gt;region_<wbr>begin_offset) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!PAGE_A=
LIGNED(region-&gt;region_<wbr>end_offset)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_err(&amp;vsoc_dev.dev-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;region %d not aligned (%x:%x)&quot=
;, i,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0region-&gt;region_begin_offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0region-&gt;region_end_offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vsoc_remove_device(pdev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (region-&gt;region=
_begin_offset &gt;=3D region-&gt;region_end_offset ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0region-=
&gt;region_end_offset &gt; vsoc_dev.shm_size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_err(&amp;vsoc_dev.dev-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;region %d offsets are wrong: %x %x=
 %zx&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i, region-&gt;region_begin_offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0region-&gt;region_end_offset, vsoc_dev.s=
hm_size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vsoc_remove_device(pdev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (region-&gt;manage=
d_by &gt;=3D vsoc_dev.layout-&gt;region_count) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_err(&amp;vsoc_dev.dev-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;region %d has invalid owner: %u&qu=
ot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i, region-&gt;managed_by);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vsoc_remove_device(pdev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vsoc_dev.msix_enabled =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; vsoc_dev.layout-&gt;region_c=
ount; ++i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct vsoc_dev=
ice_region *region =3D vsoc_dev.regions + i;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t name_sz =3D si=
zeof(vsoc_dev.regions_data[<wbr>i].name) - 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct vsoc_sig=
nal_table_layout *h_to_g_signal_table =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&amp;region-&gt;host_to_guest_signal_<wbr>table;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct vsoc_sig=
nal_table_layout *g_to_h_signal_table =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&amp;region-&gt;guest_to_host_signal_<wbr>table;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.regions_data=
[i].name[<wbr>name_sz] =3D &#39;\0&#39;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(vsoc_dev.regio=
ns_data[<wbr>i].name, region-&gt;device_name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 name_sz);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(&amp;pdev-&g=
t;dev, &quot;region %d name=3D%s\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 i, vsoc_dev.regions_data[i].name)<wbr>;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init_waitqueue_head(<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;vsoc_dev.regions_data[i].<wbr>inter=
rupt_wait_queue);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0init_waitqueue_head(&=
amp;vsoc_dev.<wbr>regions_data[i].futex_wait_<wbr>queue);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.regions_data=
[i].<wbr>incoming_signalled =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vsoc_dev.kernel_mapped_shm +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0region-&gt;region_begin_offset +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0h_to_g_signal_table-&gt;<wbr>interrupt_signalled_offset;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.regions_data=
[i].<wbr>outgoing_signalled =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vsoc_dev.kernel_mapped_shm +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0region-&gt;region_begin_offset +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0g_to_h_signal_table-&gt;<wbr>interrupt_signalled_offset;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result =3D request_ir=
q(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.msix_entries[i].<wbr>vector,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_interrupt, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.regions_data[i].name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.regions_data + i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (result) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_info(&amp;pdev-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;request_irq failed irq=3D%d vecto=
r=3D%d\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i, vsoc_dev.msix_entries[i].<wbr>vector)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vsoc_remove_device(pdev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -ENOSPC;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.regions_data=
[i].irq_<wbr>requested =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!device_create(vs=
oc_dev.<wbr>class, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MKDEV(vsoc_dev.major, i),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, vsoc_dev.regions_data[i].n=
ame)<wbr>) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_err(&amp;vsoc_dev.dev-&gt;dev, &quot;device_create failed\n&quot=
;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vsoc_remove_device(pdev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -EBUSY;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.regions_data=
[i].<wbr>device_created =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * This should undo all of the allocations in the probe function in r=
everse<br>
&gt; + * order.<br>
&gt; + *<br>
&gt; + * Notes:<br>
&gt; + *<br>
&gt; + *=C2=A0 =C2=A0The device may have been partially initialized, so dou=
ble check<br>
&gt; + *=C2=A0 =C2=A0that the allocations happened.<br>
&gt; + *<br>
&gt; + *=C2=A0 =C2=A0This function may be called multiple times, so mark re=
sources as freed<br>
&gt; + *=C2=A0 =C2=A0as they are deallocated.<br>
&gt; + */<br>
&gt; +static void vsoc_remove_device(struct pci_dev *pdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * pdev is the first thing to be set on probe and=
 the last thing<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * to be cleared here. If it&#39;s NULL then ther=
e is no cleanup.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!pdev || !vsoc_dev.dev)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dev_info(&amp;pdev-&gt;dev, &quot;remove_device\n=
&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (vsoc_dev.regions_data) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; =
vsoc_dev.layout-&gt;region_count; ++i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (vsoc_dev.regions_data[i].<wbr>device_created) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_destroy(vsoc_dev.class,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 MKDEV(vsoc_dev.major, i));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.regions_data[i].<wbr>device_cre=
ated =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (vsoc_dev.regions_data[i].irq_<wbr>requested)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_irq(vsoc_dev.msix_<wbr>entries[i].v=
ector, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vsoc_dev.regions_data[i].irq_<wbr>requested =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(vsoc_dev.region=
s_data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.regions_data=
 =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (vsoc_dev.msix_enabled) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_disable_msix(pdev=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.msix_enabled=
 =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0kfree(vsoc_dev.msix_entries);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vsoc_dev.msix_entries =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vsoc_dev.regions =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (vsoc_dev.class) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0class_destroy(vsoc_de=
v.class);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.class =3D 0;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (vsoc_dev.cdev_added) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cdev_del(&amp;vsoc_de=
v.cdev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.cdev_added =
=3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (vsoc_dev.major &amp;&amp; vsoc_dev.layout) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unregister_chrdev_reg=
ion(<wbr>MKDEV(vsoc_dev.major, 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vsoc_dev.la=
yout-&gt;region_count)<wbr>;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.major =3D 0;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vsoc_dev.layout =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (vsoc_dev.kernel_mapped_shm &amp;&amp; pdev) {=
<br>
</div></div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^^^^<br>
These tests can be removed since we checked at the start of the function.<b=
r>
<span class=3D""><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_iounmap(pdev, vso=
c_dev.kernel_mapped_shm);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.kernel_mappe=
d_shm =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (vsoc_dev.regs &amp;&amp; pdev) {<br>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^<br>
<span class=3D"">&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_=
iounmap(pdev, vsoc_dev.regs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.regs =3D 0;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (vsoc_dev.requested_regions &amp;&amp; pdev) {=
<br>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ^^^^<br>
<span class=3D"">&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_=
release_regions(pdev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.requested_re=
gions =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (vsoc_dev.enabled_device &amp;&amp; pdev) {<br=
>
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^=
^^<br>
<span class=3D"">&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_=
disable_device(pdev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vsoc_dev.enabled_devi=
ce =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Do this last: it indicates that the device is =
not initialized. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vsoc_dev.dev =3D NULL;<br>
&gt; +}<br>
&gt; +<br>
<br>
</span>regards,<br>
dan carpenter<br>
<br>
</blockquote></div><br></div>

--001a1144273c0b66de0569964530--
