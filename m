Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162672AbeCAWgX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 17:36:23 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46797 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162614AbeCAWgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 17:36:20 -0500
X-Google-Smtp-Source: AG47ELtbRX+sCcEMcct4mAXo/xJASci/r5+a3A20TAeQwyYaSTkaBQWDTEyrFhXp+AMRl4axj2ECYQ==
Subject: Re: [PATCH v4 1/4] of: change overlay apply input data from
 unflattened to FDT
To: Rob Herring <robh+dt@kernel.org>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
References: <1519927256-4868-1-git-send-email-frowand.list@gmail.com>
 <1519927256-4868-2-git-send-email-frowand.list@gmail.com>
 <CAL_JsqL9r8d4wZ0qrsE2fbK4siVWwuyq_9x4RcFJta_7RRhUyg@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <53b47afa-f7df-777a-6a96-d0b986a389fb@gmail.com>
Date: Thu, 1 Mar 2018 14:36:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL9r8d4wZ0qrsE2fbK4siVWwuyq_9x4RcFJta_7RRhUyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/18 13:02, Rob Herring wrote:
> On Thu, Mar 1, 2018 at 12:00 PM,  <frowand.list@gmail.com> wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Move duplicating and unflattening of an overlay flattened devicetree
>> (FDT) into the overlay application code.  To accomplish this,
>> of_overlay_apply() is replaced by of_overlay_fdt_apply().
>>
>> The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
>> code, which is thus responsible for freeing the duplicate FDT.  The
>> caller of of_overlay_fdt_apply() remains responsible for freeing the
>> original FDT.
>>
>> The unflattened devicetree now belongs to devicetree code, which is
>> thus responsible for freeing the unflattened devicetree.
>>
>> These ownership changes prevent early freeing of the duplicated FDT
>> or the unflattened devicetree, which could result in use after free
>> errors.
>>
>> of_overlay_fdt_apply() is a private function for the anticipated
>> overlay loader.
>>
>> Update unittest.c to use of_overlay_fdt_apply() instead of
>> of_overlay_apply().
>>
>> Move overlay fragments from artificial locations in
>> drivers/of/unittest-data/tests-overlay.dtsi into one devicetree
>> source file per overlay.  This led to changes in
>> drivers/of/unitest-data/Makefile and drivers/of/unitest.c.
>>
>>   - Add overlay directives to the overlay devicetree source files so
>>     that dtc will compile them as true overlays into one FDT data
>>     chunk per overlay.
>>
>>   - Set CFLAGS for drivers/of/unittest-data/testcases.dts so that
>>     symbols will be generated for overlay resolution of overlays
>>     that are no longer artificially contained in testcases.dts
>>
>>   - Unflatten and apply each unittest overlay FDT using
>>     of_overlay_fdt_apply().
>>
>>   - Enable the of_resolve_phandles() check for whether the unflattened
>>     overlay is detached.  This check was previously disabled because the
>>     overlays from tests-overlay.dtsi were not unflattened into detached
>>     trees.
>>
>>   - Other changes to unittest.c infrastructure to manage multiple test
>>     FDTs built into the kernel image (access by name instead of
>>     arbitrary number).
>>
>>   - of_unittest_overlay_high_level(): previously unused code to add
>>     properties from the overlay_base devicetree to the live tree
>>     was triggered by the restructuring of tests-overlay.dtsi and thus
>>     testcases.dts.  This exposed two bugs: (1) the need to dup a
>>     property before adding it, and (2) property 'name' is
>>     auto-generated in the unflatten code and thus will be a duplicate
>>     in the __symbols__ node - do not treat this duplicate as an error.
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>
>> There are checkpatch warnings.  I have reviewed them and feel they
>> can be ignored.  They are "line over 80 characters" for either
>> pre-existing long lines, or lines in devicetree source files.
>>
>> Changes from v3:
>>   - OF_OVERLAY: add select OF_FLATTREE
>>
>> Changes from v1:
>>   - rebase on v4.16-rc1
>>
>>  drivers/of/Kconfig                          |   1 +
>>  drivers/of/of_private.h                     |   1 +
>>  drivers/of/overlay.c                        | 107 +++++++++-
>>  drivers/of/resolver.c                       |   6 -
>>  drivers/of/unittest-data/Makefile           |  28 ++-
>>  drivers/of/unittest-data/overlay_0.dts      |  14 ++
>>  drivers/of/unittest-data/overlay_1.dts      |  14 ++
>>  drivers/of/unittest-data/overlay_10.dts     |  34 ++++
>>  drivers/of/unittest-data/overlay_11.dts     |  34 ++++
>>  drivers/of/unittest-data/overlay_12.dts     |  14 ++
>>  drivers/of/unittest-data/overlay_13.dts     |  14 ++
>>  drivers/of/unittest-data/overlay_15.dts     |  35 ++++
>>  drivers/of/unittest-data/overlay_2.dts      |  14 ++
>>  drivers/of/unittest-data/overlay_3.dts      |  14 ++
>>  drivers/of/unittest-data/overlay_4.dts      |  23 +++
>>  drivers/of/unittest-data/overlay_5.dts      |  14 ++
>>  drivers/of/unittest-data/overlay_6.dts      |  15 ++
>>  drivers/of/unittest-data/overlay_7.dts      |  15 ++
>>  drivers/of/unittest-data/overlay_8.dts      |  15 ++
>>  drivers/of/unittest-data/overlay_9.dts      |  15 ++
>>  drivers/of/unittest-data/tests-overlay.dtsi | 213 --------------------
>>  drivers/of/unittest.c                       | 294 ++++++++++++++--------------
>>  include/linux/of.h                          |   7 -
>>  23 files changed, 552 insertions(+), 389 deletions(-)
>>  create mode 100644 drivers/of/unittest-data/overlay_0.dts
>>  create mode 100644 drivers/of/unittest-data/overlay_1.dts
>>  create mode 100644 drivers/of/unittest-data/overlay_10.dts
>>  create mode 100644 drivers/of/unittest-data/overlay_11.dts
>>  create mode 100644 drivers/of/unittest-data/overlay_12.dts
>>  create mode 100644 drivers/of/unittest-data/overlay_13.dts
>>  create mode 100644 drivers/of/unittest-data/overlay_15.dts
>>  create mode 100644 drivers/of/unittest-data/overlay_2.dts
>>  create mode 100644 drivers/of/unittest-data/overlay_3.dts
>>  create mode 100644 drivers/of/unittest-data/overlay_4.dts
>>  create mode 100644 drivers/of/unittest-data/overlay_5.dts
>>  create mode 100644 drivers/of/unittest-data/overlay_6.dts
>>  create mode 100644 drivers/of/unittest-data/overlay_7.dts
>>  create mode 100644 drivers/of/unittest-data/overlay_8.dts
>>  create mode 100644 drivers/of/unittest-data/overlay_9.dts
>>
>> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
>> index 783e0870bd22..ad3fcad4d75b 100644
>> --- a/drivers/of/Kconfig
>> +++ b/drivers/of/Kconfig
>> @@ -92,6 +92,7 @@ config OF_RESOLVE
>>  config OF_OVERLAY
>>         bool "Device Tree overlays"
>>         select OF_DYNAMIC
>> +       select OF_FLATTREE
>>         select OF_RESOLVE
>>         help
>>           Overlays are a method to dynamically modify part of the kernel's
>> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
>> index 0c609e7d0334..6e39dce3a979 100644
>> --- a/drivers/of/of_private.h
>> +++ b/drivers/of/of_private.h
>> @@ -77,6 +77,7 @@ static inline void __of_detach_node_sysfs(struct device_node *np) {}
>>  #endif
>>
>>  #if defined(CONFIG_OF_OVERLAY)
>> +int of_overlay_fdt_apply(void *overlay_fdt, int *ovcs_id);
>>  void of_overlay_mutex_lock(void);
>>  void of_overlay_mutex_unlock(void);
>>  #else
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index 3397d7642958..5f6c5569e97d 100644
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -12,10 +12,12 @@
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>> +#include <linux/of_fdt.h>
>>  #include <linux/string.h>
>>  #include <linux/ctype.h>
>>  #include <linux/errno.h>
>>  #include <linux/slab.h>
>> +#include <linux/libfdt.h>
>>  #include <linux/err.h>
>>  #include <linux/idr.h>
>>
>> @@ -33,7 +35,9 @@ struct fragment {
>>
>>  /**
>>   * struct overlay_changeset
>> + * @id:                        changeset identifier
>>   * @ovcs_list:         list on which we are located
>> + * @fdt:               FDT that was unflattened to create @overlay_tree
>>   * @overlay_tree:      expanded device tree that contains the fragment nodes
>>   * @count:             count of fragment structures
>>   * @fragments:         fragment nodes in the overlay expanded device tree
>> @@ -43,6 +47,7 @@ struct fragment {
>>  struct overlay_changeset {
>>         int id;
>>         struct list_head ovcs_list;
>> +       const void *fdt;
>>         struct device_node *overlay_tree;
>>         int count;
>>         struct fragment *fragments;
>> @@ -503,7 +508,8 @@ static struct device_node *find_target_node(struct device_node *info_node)
>>
>>  /**
>>   * init_overlay_changeset() - initialize overlay changeset from overlay tree
>> - * @ovcs       Overlay changeset to build
>> + * @ovcs:      Overlay changeset to build
>> + * @fdt:       the FDT that was unflattened to create @tree
>>   * @tree:      Contains all the overlay fragments and overlay fixup nodes
>>   *
>>   * Initialize @ovcs.  Populate @ovcs->fragments with node information from
>> @@ -514,7 +520,7 @@ static struct device_node *find_target_node(struct device_node *info_node)
>>   * detected in @tree, or -ENOSPC if idr_alloc() error.
>>   */
>>  static int init_overlay_changeset(struct overlay_changeset *ovcs,
>> -               struct device_node *tree)
>> +               const void *fdt, struct device_node *tree)
>>  {
>>         struct device_node *node, *overlay_node;
>>         struct fragment *fragment;
>> @@ -535,6 +541,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
>>                 pr_debug("%s() tree is not root\n", __func__);
>>
>>         ovcs->overlay_tree = tree;
>> +       ovcs->fdt = fdt;
>>
>>         INIT_LIST_HEAD(&ovcs->ovcs_list);
>>
>> @@ -606,6 +613,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs,
>>         }
>>
>>         if (!cnt) {
>> +               pr_err("no fragments or symbols in overlay\n");
>>                 ret = -EINVAL;
>>                 goto err_free_fragments;
>>         }
>> @@ -642,11 +650,24 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>         }
>>         kfree(ovcs->fragments);
>>
>> +       /*
>> +        * TODO
>> +        *
>> +        * would like to: kfree(ovcs->overlay_tree);
>> +        * but can not since drivers may have pointers into this data
>> +        *
>> +        * would like to: kfree(ovcs->fdt);
>> +        * but can not since drivers may have pointers into this data
>> +        */
>> +
>>         kfree(ovcs);
>>  }
>>
>> -/**
>> +/*
>> + * internal documentation
>> + *
>>   * of_overlay_apply() - Create and apply an overlay changeset
>> + * @fdt:       the FDT that was unflattened to create @tree
>>   * @tree:      Expanded overlay device tree
>>   * @ovcs_id:   Pointer to overlay changeset id
>>   *
>> @@ -685,21 +706,29 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>   * id is returned to *ovcs_id.
>>   */
>>
>> -int of_overlay_apply(struct device_node *tree, int *ovcs_id)
>> +static int of_overlay_apply(const void *fdt, struct device_node *tree,
>> +               int *ovcs_id)
>>  {
>>         struct overlay_changeset *ovcs;
>>         int ret = 0, ret_revert, ret_tmp;
>>
>> -       *ovcs_id = 0;
>> +       /*
>> +        * As of this point, fdt and tree belong to the overlay changeset.
>> +        * overlay changeset code is responsible for freeing them.
>> +        */
>>
>>         if (devicetree_corrupt()) {
>>                 pr_err("devicetree state suspect, refuse to apply overlay\n");
>> +               kfree(fdt);
>> +               kfree(tree);
>>                 ret = -EBUSY;
>>                 goto out;
>>         }
>>
>>         ovcs = kzalloc(sizeof(*ovcs), GFP_KERNEL);
>>         if (!ovcs) {
>> +               kfree(fdt);
> 
> You free the fdt up here, but ...
> 
>> +               kfree(tree);
>>                 ret = -ENOMEM;
>>                 goto out;
>>         }
>> @@ -709,12 +738,17 @@ int of_overlay_apply(struct device_node *tree, int *ovcs_id)
>>
>>         ret = of_resolve_phandles(tree);
>>         if (ret)
>> -               goto err_free_overlay_changeset;
>> +               goto err_free_tree;
>>
>> -       ret = init_overlay_changeset(ovcs, tree);
>> +       ret = init_overlay_changeset(ovcs, fdt, tree);
>>         if (ret)
>> -               goto err_free_overlay_changeset;
>> +               goto err_free_tree;
>>
>> +       /*
>> +        * after overlay_notify(), ovcs->overlay_tree related pointers may have
>> +        * leaked to drivers, so can not kfree() tree, aka ovcs->overlay_tree;
>> +        * and can not free fdt, aka ovcs->fdt
>> +        */
>>         ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
>>         if (ret) {
>>                 pr_err("overlay changeset pre-apply notify error %d\n", ret);
>> @@ -754,6 +788,9 @@ int of_overlay_apply(struct device_node *tree, int *ovcs_id)
>>
>>         goto out_unlock;
>>
>> +err_free_tree:
>> +       kfree(tree);
>> +
> 
> ...not down here?
> 
> Seems like of_overlay_fdt_apply should do the freeing as that is what
> does the allocation of the fdt.

Yes, fdt should be freed here also.


>>  err_free_overlay_changeset:
>>         free_overlay_changeset(ovcs);
>>
>> @@ -766,7 +803,59 @@ int of_overlay_apply(struct device_node *tree, int *ovcs_id)
>>
>>         return ret;
>>  }
>> -EXPORT_SYMBOL_GPL(of_overlay_apply);
>> +
>> +int of_overlay_fdt_apply(void *overlay_fdt, int *ovcs_id)
>> +{
>> +       const void *new_fdt;
>> +       int ret;
>> +       u32 size;
>> +       struct device_node *overlay_root;
>> +
>> +       *ovcs_id = 0;
>> +       ret = 0;
>> +
>> +       if (fdt_check_header(overlay_fdt)) {
>> +               pr_err("Invalid overlay_fdt header\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       size = fdt_totalsize(overlay_fdt);
>> +
>> +       /*
>> +        * Must create permanent copy of FDT because of_fdt_unflatten_tree()
>> +        * will create pointers to the passed in FDT in the unflattened tree.
>> +        */
>> +       new_fdt = kmemdup(overlay_fdt, size, GFP_KERNEL);
>> +       if (!new_fdt)
>> +               return -ENOMEM;
>> +
>> +       of_fdt_unflatten_tree(new_fdt, NULL, &overlay_root);
>> +       if (!overlay_root) {
>> +               pr_err("unable to unflatten overlay_fdt\n");
>> +               ret = -EINVAL;
>> +               goto out_free_new_fdt;
>> +       }
>> +
>> +       ret = of_overlay_apply(new_fdt, overlay_root, ovcs_id);
>> +       if (ret < 0) {
>> +               /*
>> +                * new_fdt and overlay_root now belong to the overlay
>> +                * changeset.
>> +                * overlay changeset code is responsible for freeing them.
>> +                */
>> +               goto out;
>> +       }
>> +
>> +       return 0;
>> +
>> +
>> +out_free_new_fdt:
>> +       kfree(new_fdt);
>> +
>> +out:
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(of_overlay_fdt_apply);
> 
> [...]
> 
>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>> index 7a9abaae874d..2d706039ac96 100644
>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
>> @@ -45,6 +45,8 @@
>>         failed; \
>>  })
>>
>> +static int __init overlay_data_apply(const char *overlay_name, int *overlay_id);
>> +
>>  static void __init of_unittest_find_node_by_name(void)
>>  {
>>         struct device_node *np;
>> @@ -997,8 +999,7 @@ static int __init unittest_data_add(void)
>>         }
>>
>>         /*
>> -        * This lock normally encloses of_overlay_apply() as well as
>> -        * of_resolve_phandles().
>> +        * This lock normally encloses of_resolve_phandles()
> 
> I thought this lock was going to be internal when we did this change.

Not quite there yet.  I managed to pull all of the overlay fragments out
of tests-overlay.dtsi, but the overlay fragments still have references back
into testcases.dtb.  unittest_data_add() is fixing up the phandle values
in testcases.dtb (even though it is not an overlay) and then splicing
testcases.dtb into the live tree.

Modifying the overlays to not refer back into testcases.dtb is yet another
largish project.


>>          */
>>         of_overlay_mutex_lock();
>>
>> @@ -1191,12 +1192,12 @@ static int of_unittest_device_exists(int unittest_nr, enum overlay_type ovtype)
>>         return 0;
>>  }
>>
>> -static const char *overlay_path(int nr)
>> +static const char *overlay_name_from_nr(int nr)
>>  {
>>         static char buf[256];
>>
>>         snprintf(buf, sizeof(buf) - 1,
>> -               "/testcase-data/overlay%d", nr);
>> +               "overlay_%d", nr);
>>         buf[sizeof(buf) - 1] = '\0';
>>
>>         return buf;
>> @@ -1263,25 +1264,19 @@ static void of_unittest_destroy_tracked_overlays(void)
>>         } while (defers > 0);
>>  }
>>
>> -static int of_unittest_apply_overlay(int overlay_nr, int unittest_nr,
>> +static int __init of_unittest_apply_overlay(int overlay_nr, int unittest_nr,
>>                 int *overlay_id)
> 
> Why __init? Really, we want to move towards building the unittests as
> a module and we don't want __init for that. Though maybe __init is a
> nop for modules, I don't remember offhand.

It has to be a nop for modules.

__init makes sense when the unittests are an initcall.


> In any case, seems like a separate change.

Correct.  It was a gratuitous clean up when I was making other changes
to the function.  I'll remove it from this series.

There is a mix of some functions being marked __init and some not,
so that will be worth another patch someday.


> 
> Rob
> 
