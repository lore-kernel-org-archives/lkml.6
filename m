Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967157AbeBNKWJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:22:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:48306 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966996AbeBNKWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:22:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,511,1511856000";
   d="scan'208";a="34594307"
Date: Wed, 14 Feb 2018 12:22:03 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Radion Mirchevsky <radion.mirchevsky@intel.com>
Subject: Re: [PATCH 16/18] thunderbolt: Add support for preboot ACL
Message-ID: <20180214102203.GN27191@lahna.fi.intel.com>
References: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
 <20180213170018.9780-17-mika.westerberg@linux.intel.com>
 <CAHp75VePM_zL-zyZSO+3BN1O3KhWpeKKsKg_V2XKFD4+yfpVrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VePM_zL-zyZSO+3BN1O3KhWpeKKsKg_V2XKFD4+yfpVrA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 08:19:45PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 13, 2018 at 7:00 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > Preboot ACL is a mechanism that allows connecting Thunderbolt devices
> > boot time in more secure way than the legacy Thunderbolt boot support.
> > As with the legacy boot option, this also needs to be enabled from the
> > BIOS before booting is allowed. Difference to the legacy mode is that
> > the userspace software explicitly adds device UUIDs by sending a special
> > message to the ICM firmware. Only the devices listed in the boot ACL are
> > connected automatically during the boot. This works in both "user" and
> > "secure" security levels.
> >
> > We implement this in Linux by exposing a new sysfs attribute (boot_acl)
> > below each Thunderbolt domain. The userspace software can then update
> > the full list as needed.
> 
> > +       if (mutex_lock_interruptible(&tb->lock)) {
> > +               ret = -ERESTARTSYS;
> > +               goto out;
> > +       }
> 
> > +       ret = tb->cm_ops->get_boot_acl(tb, uuids, tb->nboot_acl);
> > +       mutex_unlock(&tb->lock);
> > +
> > +       if (ret)
> > +               goto out;
> 
> Can we use more traditional pattern, i.e.
> mutex_lock();
> ret = ...;
> if (ret) {
>  ...
>  mutex_unlock();
>  goto ...;
> }
> mutex_unlock();
> 
> ?

OK.

> > +       for (ret = 0, i = 0; i < tb->nboot_acl; i++) {
> 
> Wouldn't be slightly better to check for overflow beforehand
> 
> i < min(PAGE_SIZE / (UUID_STRING_LEN + 1), tb->nboot_acl)
> 
> and then simple
> 
> ret = sprintf(buf + ret, "%pUb", &uuids[i]);
> 
> ?

Well, this follows the common pattern used with formatting sysfs
attributes.

> > +               if (!uuid_is_null(&uuids[i]))
> > +                       ret += snprintf(buf + ret, PAGE_SIZE - ret, "%pUb",
> > +                                       &uuids[i]);
> > +
> > +               ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s",
> > +                              i < tb->nboot_acl - 1 ? "," : "\n");
> > +       }
> 
> 
> > +static ssize_t boot_acl_store(struct device *dev, struct device_attribute *attr,
> > +                             const char *buf, size_t count)
> > +{
> 
> > +       int i = 0;
> 
> > +       uuid_str = strim(str);
> 
> > +       while ((s = strsep(&uuid_str, ",")) != NULL && i < tb->nboot_acl) {
> 
> for (i = 0; (s = strsep(&uuid_str, ",")) != NULL && i < tb->nboot_acl; i++) {
>   size_t len = strlen(s);
> 
>   if (!len)
>     continue;
> ...
> }
> 
> ?

I think the way it is done in this patch is more readable than what you
are proposing ;-)

> Btw, nboot_acl can be 0, right? Perhaps check it first? (Or in other
> words: which one is anticipated to be more frequent: nboot_acl = 0, or
> string w/o any ',' in it?)

If nboot_acl is 0 the sysfs attribute is not visible at all.

> > +               size_t len = strlen(s);
> > +
> > +               if (len) {
> 
> 
> > +                       if (len != UUID_STRING_LEN) {
> > +                               ret = -EINVAL;
> > +                               goto err_free_acl;
> > +                       }
> 
> uuid_parse() does this check. No need to duplicate.

It does not actually. Only thing it checks that the string is at least
UUID_STRING_LEN. If the string is longer it just ignores the rest. We
on the other side want to have strictly UUID_STRING_LEN strings.

Thanks for the comments :)
