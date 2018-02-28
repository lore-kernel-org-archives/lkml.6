Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932984AbeB1Pc7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:32:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932170AbeB1Pc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:32:56 -0500
Date: Wed, 28 Feb 2018 17:32:52 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: open list <linux-kernel@vger.kernel.org>, slp@redhat.com,
        bhe@redhat.com, somlo@cmu.edu, xiaolong.ye@intel.com
Subject: Re: [PATCH v15 08/11] fw_cfg: handle fw_cfg_read_blob() error
Message-ID: <20180228173014-mutt-send-email-mst@kernel.org>
References: <20180215213312.29234-1-marcandre.lureau@redhat.com>
 <20180215213312.29234-9-marcandre.lureau@redhat.com>
 <20180227021150-mutt-send-email-mst@kernel.org>
 <CAJ+F1CKwBjRDTxToDwOrPnnaiMHvF6EgK=dgSC-FW7n6UMDeKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CKwBjRDTxToDwOrPnnaiMHvF6EgK=dgSC-FW7n6UMDeKA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 12:49:35PM +0100, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Feb 27, 2018 at 1:20 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Thu, Feb 15, 2018 at 10:33:09PM +0100, Marc-André Lureau wrote:
> >> fw_cfg_read_blob() may fail, but does not return error. This may lead
> >> to undefined behaviours, such as a memcmp(sig, "QEMU") on uninitilized
> >> memory.
> >
> > I don't think that's true - there's a memset there that
> > will initialize the memory. probe is likely the only
> > case where it returns a slightly incorrect data.
> 
> Right, I'll update the commit message.
> 
> >> Return an error if ACPI locking failed. Also, the following
> >> DMA read/write extension will add more error paths that should be
> >> handled appropriately.
> >>
> >> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> >> ---
> >>  drivers/firmware/qemu_fw_cfg.c | 32 ++++++++++++++++++++++----------
> >>  1 file changed, 22 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> >> index f6f90bef604c..5e6e5ac71dab 100644
> >> --- a/drivers/firmware/qemu_fw_cfg.c
> >> +++ b/drivers/firmware/qemu_fw_cfg.c
> >> @@ -59,8 +59,8 @@ static void fw_cfg_sel_endianness(u16 key)
> >>  }
> >>
> >>  /* read chunk of given fw_cfg blob (caller responsible for sanity-check) */
> >> -static void fw_cfg_read_blob(u16 key,
> >> -                     void *buf, loff_t pos, size_t count)
> >> +static ssize_t fw_cfg_read_blob(u16 key,
> >> +                             void *buf, loff_t pos, size_t count)
> >>  {
> >>       u32 glk = -1U;
> >>       acpi_status status;
> >> @@ -73,7 +73,7 @@ static void fw_cfg_read_blob(u16 key,
> >>               /* Should never get here */
> >>               WARN(1, "fw_cfg_read_blob: Failed to lock ACPI!\n");
> >>               memset(buf, 0, count);
> >> -             return;
> >> +             return -EINVAL;
> >>       }
> >>
> >>       mutex_lock(&fw_cfg_dev_lock);
> >
> > Wouldn't something like -EBUSY be more appropriate?
> 
> In theory, it would be a general failure right? I don't think we want
> the caller to retry. I think in EINVAL fits better, but I don't think
> it matters much this or EBUSY.
> 
> >> @@ -84,6 +84,7 @@ static void fw_cfg_read_blob(u16 key,
> >>       mutex_unlock(&fw_cfg_dev_lock);
> >>
> >>       acpi_release_global_lock(glk);
> >> +     return count;
> >>  }
> >>
> >>  /* clean up fw_cfg device i/o */
> >> @@ -165,8 +166,9 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
> >>       }
> >>
> >>       /* verify fw_cfg device signature */
> >> -     fw_cfg_read_blob(FW_CFG_SIGNATURE, sig, 0, FW_CFG_SIG_SIZE);
> >> -     if (memcmp(sig, "QEMU", FW_CFG_SIG_SIZE) != 0) {
> >> +     if (fw_cfg_read_blob(FW_CFG_SIGNATURE, sig,
> >> +                             0, FW_CFG_SIG_SIZE) < 0 ||
> >> +             memcmp(sig, "QEMU", FW_CFG_SIG_SIZE) != 0) {
> >>               fw_cfg_io_cleanup();
> >>               return -ENODEV;
> >>       }
> >> @@ -326,8 +328,7 @@ static ssize_t fw_cfg_sysfs_read_raw(struct file *filp, struct kobject *kobj,
> >>       if (count > entry->size - pos)
> >>               count = entry->size - pos;
> >>
> >> -     fw_cfg_read_blob(entry->select, buf, pos, count);
> >> -     return count;
> >> +     return fw_cfg_read_blob(entry->select, buf, pos, count);
> >>  }
> >>
> >>  static struct bin_attribute fw_cfg_sysfs_attr_raw = {
> >> @@ -483,7 +484,11 @@ static int fw_cfg_register_dir_entries(void)
> >>       struct fw_cfg_file *dir;
> >>       size_t dir_size;
> >>
> >> -     fw_cfg_read_blob(FW_CFG_FILE_DIR, &files_count, 0, sizeof(files_count));
> >> +     ret = fw_cfg_read_blob(FW_CFG_FILE_DIR, &files_count,
> >> +                     0, sizeof(files_count));
> >> +     if (ret < 0)
> >> +             return ret;
> >> +
> >>       count = be32_to_cpu(files_count);
> >>       dir_size = count * sizeof(struct fw_cfg_file);
> >>
> >> @@ -491,7 +496,10 @@ static int fw_cfg_register_dir_entries(void)
> >>       if (!dir)
> >>               return -ENOMEM;
> >>
> >> -     fw_cfg_read_blob(FW_CFG_FILE_DIR, dir, sizeof(files_count), dir_size);
> >> +     ret = fw_cfg_read_blob(FW_CFG_FILE_DIR, dir,
> >> +                     sizeof(files_count), dir_size);
> >> +     if (ret < 0)
> >> +             goto end;
> >>
> >>       for (i = 0; i < count; i++) {
> >>               ret = fw_cfg_register_file(&dir[i]);
> >> @@ -499,6 +507,7 @@ static int fw_cfg_register_dir_entries(void)
> >>                       break;
> >>       }
> >>
> >> +end:
> >>       kfree(dir);
> >>       return ret;
> >>  }
> >> @@ -539,7 +548,10 @@ static int fw_cfg_sysfs_probe(struct platform_device *pdev)
> >>               goto err_probe;
> >>
> >>       /* get revision number, add matching top-level attribute */
> >> -     fw_cfg_read_blob(FW_CFG_ID, &rev, 0, sizeof(rev));
> >> +     err = fw_cfg_read_blob(FW_CFG_ID, &rev, 0, sizeof(rev));
> >> +     if (err < 0)
> >> +             goto err_probe;
> >> +
> >>       fw_cfg_rev = le32_to_cpu(rev);
> >>       err = sysfs_create_file(fw_cfg_top_ko, &fw_cfg_rev_attr.attr);
> >>       if (err)
> >
> > I think that this is the only case where it's not doing the right thing right now in
> > that it shows 0 as the revision to the users.  Is it worth failing probe
> > here?  We could just skip the attribute, could we not?
> 
> I think it's best to fail the probe if we have a read failure at that time.

I'd rather we just dropped this attribute completely.
Why is it there?
Does any userspace actually need it?
Gabriel?

> -- 
> Marc-André Lureau
