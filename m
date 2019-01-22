Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AE4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1B020870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfAVVSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:18:36 -0500
Received: from mleia.com ([178.79.152.223]:58462 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfAVVSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:18:31 -0500
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id C6A2A43C8E9;
        Tue, 22 Jan 2019 21:18:27 +0000 (GMT)
From:   Vladimir Zapolskiy <vz@mleia.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Meunier <laurent.meunier@st.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@arm.linux.org.uk>
Subject: [PATCH v2 2/2] pinctrl: remove unused 'pinconf-config' debugfs interface
Date:   Tue, 22 Jan 2019 23:18:22 +0200
Message-Id: <20190122211822.7016-3-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122211822.7016-1-vz@mleia.com>
References: <20190122211822.7016-1-vz@mleia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190122_211827_834754_2D965C05 
X-CRM114-Status: GOOD (  37.17  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main goal of the change is to remove .pin_config_dbg_parse_modify
callback before a driver with its support appears. So far the in-kernel
interface did not attract any users since its introduction 5 years ago.

Originally .pin_config_dbg_parse_modify callback and the associated
'pinconf-config' debugfs file were introduced in commit f07512e615dd
("pinctrl/pinconfig: add debug interface"), a short description of
'pinconf-config' usage for debugging can be expressed this way:

Write to 'pinconf-config' (see pinconf_dbg_config_write() function):

% echo -n modify $map_type $device_name $state_name $pin_name $config > \
	/sys/kernel/debug/pinctrl/$pinctrl/pinconf-config

It supposes to update a global (therefore single!) 'pinconf_dbg_conf'
variable with an alternative setting, the arguments should match
an existing pinconf device and some registered pinctrl mapping 'map':

* $map_type is either 'config_pin' or 'config_group', it should match
  'map->type' value of PIN_MAP_TYPE_CONFIGS_PIN or
   PIN_MAP_TYPE_CONFIGS_GROUP accordingly,
* $device_name should match 'map->dev_name' string value,
* $state_name should match 'map->name' string value,
* $pin_name should match 'map->data.configs.group_or_pin' string value,

If all above has matched, then $config is a new value to be set by calling
pinconfops->pin_config_dbg_parse_modify(pctldev, config, matched_config).

After a successful write into 'pinconf-config' a user can read the file
to get information about that single modified pin configuration.

The fact is .pin_config_dbg_parse_modify callback has never been defined
in 'struct pinconf_ops' of any pinconf driver, thus an actual modification
of a pin or group state on any present pinconf controller does not happen,
and it declares that all related code is no more than dead code.

I discovered the issue while attempting to add .pin_config_dbg_parse_modify
support in some drivers and found that too short 'MAX_NAME_LEN' set by

  drivers/pinctrl/pinconf.c:372:#define MAX_NAME_LEN 15

is practically insufficient to store a regular pinctrl device name,
which are like 'e6060000.pin-controller-sh-pfc' or pin names like
'MX6QDL_PAD_ENET_REF_CLK', thus it is another indicator that the code
is barely usable, insufficiently tested and unprepossessing.

Of course it might be possible to increase MAX_NAME_LEN, and then add
.pin_config_dbg_parse_modify callbacks to the drivers, but the whole
idea of such a limited debug option looks inviable. A more flexible
way to functionally substitute the original approach is to implicitly
or explicitly use pinctrl_select_state() function whenever needed.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: Laurent Meunier <laurent.meunier@st.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
Changes from v1 to v2:
* moved header removal in include/linux/pinctrl/pinconf.h file to patch 1/2

 drivers/pinctrl/pinconf.c       | 222 --------------------------------
 include/linux/pinctrl/pinconf.h |   4 -
 2 files changed, 226 deletions(-)

diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
index 2c7229380f08..2678603df14b 100644
--- a/drivers/pinctrl/pinconf.c
+++ b/drivers/pinctrl/pinconf.c
@@ -17,7 +17,6 @@
 #include <linux/slab.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
-#include <linux/uaccess.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinconf.h>
@@ -369,225 +368,6 @@ static int pinconf_groups_show(struct seq_file *s, void *what)
 DEFINE_SHOW_ATTRIBUTE(pinconf_pins);
 DEFINE_SHOW_ATTRIBUTE(pinconf_groups);
 
-#define MAX_NAME_LEN 15
-
-struct dbg_cfg {
-	enum pinctrl_map_type map_type;
-	char dev_name[MAX_NAME_LEN + 1];
-	char state_name[MAX_NAME_LEN + 1];
-	char pin_name[MAX_NAME_LEN + 1];
-};
-
-/*
- * Goal is to keep this structure as global in order to simply read the
- * pinconf-config file after a write to check config is as expected
- */
-static struct dbg_cfg pinconf_dbg_conf;
-
-/**
- * pinconf_dbg_config_print() - display the pinctrl config from the pinctrl
- * map, of the dev/pin/state that was last written to pinconf-config file.
- * @s: string filled in  with config description
- * @d: not used
- */
-static int pinconf_dbg_config_print(struct seq_file *s, void *d)
-{
-	struct pinctrl_maps *maps_node;
-	const struct pinctrl_map *map;
-	const struct pinctrl_map *found = NULL;
-	struct pinctrl_dev *pctldev;
-	struct dbg_cfg *dbg = &pinconf_dbg_conf;
-	int i;
-
-	mutex_lock(&pinctrl_maps_mutex);
-
-	/* Parse the pinctrl map and look for the elected pin/state */
-	for_each_maps(maps_node, i, map) {
-		if (map->type != dbg->map_type)
-			continue;
-		if (strcmp(map->dev_name, dbg->dev_name))
-			continue;
-		if (strcmp(map->name, dbg->state_name))
-			continue;
-
-		if (!strcmp(map->data.configs.group_or_pin, dbg->pin_name)) {
-			/* We found the right pin */
-			found = map;
-			break;
-		}
-	}
-
-	if (!found) {
-		seq_printf(s, "No config found for dev/state/pin, expected:\n");
-		seq_printf(s, "Searched dev:%s\n", dbg->dev_name);
-		seq_printf(s, "Searched state:%s\n", dbg->state_name);
-		seq_printf(s, "Searched pin:%s\n", dbg->pin_name);
-		seq_printf(s, "Use: modify config_pin <devname> "\
-				"<state> <pinname> <value>\n");
-		goto exit;
-	}
-
-	pctldev = get_pinctrl_dev_from_devname(found->ctrl_dev_name);
-	seq_printf(s, "Dev %s has config of %s in state %s:\n",
-		   dbg->dev_name, dbg->pin_name, dbg->state_name);
-	pinconf_show_config(s, pctldev, found->data.configs.configs,
-			    found->data.configs.num_configs);
-
-exit:
-	mutex_unlock(&pinctrl_maps_mutex);
-
-	return 0;
-}
-
-/**
- * pinconf_dbg_config_write() - modify the pinctrl config in the pinctrl
- * map, of a dev/pin/state entry based on user entries to pinconf-config
- * @user_buf: contains the modification request with expected format:
- *     modify <config> <devicename> <state> <name> <newvalue>
- * modify is literal string, alternatives like add/delete not supported yet
- * <config> is the configuration to be changed. Supported configs are
- *     "config_pin" or "config_group", alternatives like config_mux are not
- *     supported yet.
- * <devicename> <state> <name> are values that should match the pinctrl-maps
- * <newvalue> reflects the new config and is driver dependent
- */
-static ssize_t pinconf_dbg_config_write(struct file *file,
-	const char __user *user_buf, size_t count, loff_t *ppos)
-{
-	struct pinctrl_maps *maps_node;
-	const struct pinctrl_map *map;
-	const struct pinctrl_map *found = NULL;
-	struct pinctrl_dev *pctldev;
-	const struct pinconf_ops *confops = NULL;
-	struct dbg_cfg *dbg = &pinconf_dbg_conf;
-	const struct pinctrl_map_configs *configs;
-	char config[MAX_NAME_LEN + 1];
-	char buf[128];
-	char *b = &buf[0];
-	int buf_size;
-	char *token;
-	int i;
-
-	/* Get userspace string and assure termination */
-	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-	buf[buf_size] = 0;
-
-	/*
-	 * need to parse entry and extract parameters:
-	 * modify configs_pin devicename state pinname newvalue
-	 */
-
-	/* Get arg: 'modify' */
-	token = strsep(&b, " ");
-	if (!token)
-		return -EINVAL;
-	if (strcmp(token, "modify"))
-		return -EINVAL;
-
-	/*
-	 * Get arg type: "config_pin" and "config_group"
-	 *                types are supported so far
-	 */
-	token = strsep(&b, " ");
-	if (!token)
-		return -EINVAL;
-	if (!strcmp(token, "config_pin"))
-		dbg->map_type = PIN_MAP_TYPE_CONFIGS_PIN;
-	else if (!strcmp(token, "config_group"))
-		dbg->map_type = PIN_MAP_TYPE_CONFIGS_GROUP;
-	else
-		return -EINVAL;
-
-	/* get arg 'device_name' */
-	token = strsep(&b, " ");
-	if (!token)
-		return -EINVAL;
-	if (strlen(token) >= MAX_NAME_LEN)
-		return -EINVAL;
-	strncpy(dbg->dev_name, token, MAX_NAME_LEN);
-
-	/* get arg 'state_name' */
-	token = strsep(&b, " ");
-	if (!token)
-		return -EINVAL;
-	if (strlen(token) >= MAX_NAME_LEN)
-		return -EINVAL;
-	strncpy(dbg->state_name, token, MAX_NAME_LEN);
-
-	/* get arg 'pin_name' */
-	token = strsep(&b, " ");
-	if (!token)
-		return -EINVAL;
-	if (strlen(token) >= MAX_NAME_LEN)
-		return -EINVAL;
-	strncpy(dbg->pin_name, token, MAX_NAME_LEN);
-
-	/* get new_value of config' */
-	token = strsep(&b, " ");
-	if (!token)
-		return -EINVAL;
-	if (strlen(token) >= MAX_NAME_LEN)
-		return -EINVAL;
-	strncpy(config, token, MAX_NAME_LEN);
-
-	mutex_lock(&pinctrl_maps_mutex);
-
-	/* Parse the pinctrl map and look for the selected dev/state/pin */
-	for_each_maps(maps_node, i, map) {
-		if (strcmp(map->dev_name, dbg->dev_name))
-			continue;
-		if (map->type != dbg->map_type)
-			continue;
-		if (strcmp(map->name, dbg->state_name))
-			continue;
-
-		/*  we found the right pin / state, so overwrite config */
-		if (!strcmp(map->data.configs.group_or_pin, dbg->pin_name)) {
-			found = map;
-			break;
-		}
-	}
-
-	if (!found) {
-		count = -EINVAL;
-		goto exit;
-	}
-
-	pctldev = get_pinctrl_dev_from_devname(found->ctrl_dev_name);
-	if (pctldev)
-		confops = pctldev->desc->confops;
-
-	if (confops && confops->pin_config_dbg_parse_modify) {
-		configs = &found->data.configs;
-		for (i = 0; i < configs->num_configs; i++) {
-			confops->pin_config_dbg_parse_modify(pctldev,
-						     config,
-						     &configs->configs[i]);
-		}
-	}
-
-exit:
-	mutex_unlock(&pinctrl_maps_mutex);
-
-	return count;
-}
-
-static int pinconf_dbg_config_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pinconf_dbg_config_print, inode->i_private);
-}
-
-static const struct file_operations pinconf_dbg_pinconfig_fops = {
-	.open = pinconf_dbg_config_open,
-	.write = pinconf_dbg_config_write,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
-
 void pinconf_init_device_debugfs(struct dentry *devroot,
 			 struct pinctrl_dev *pctldev)
 {
@@ -595,8 +375,6 @@ void pinconf_init_device_debugfs(struct dentry *devroot,
 			    devroot, pctldev, &pinconf_pins_fops);
 	debugfs_create_file("pinconf-groups", S_IFREG | S_IRUGO,
 			    devroot, pctldev, &pinconf_groups_fops);
-	debugfs_create_file("pinconf-config",  (S_IRUGO | S_IWUSR | S_IWGRP),
-			    devroot, pctldev, &pinconf_dbg_pinconfig_fops);
 }
 
 #endif
diff --git a/include/linux/pinctrl/pinconf.h b/include/linux/pinctrl/pinconf.h
index 109468d9d849..93c9dd133e9d 100644
--- a/include/linux/pinctrl/pinconf.h
+++ b/include/linux/pinctrl/pinconf.h
@@ -29,7 +29,6 @@ struct seq_file;
  * @pin_config_group_get: get configurations for an entire pin group; should
  *	return -ENOTSUPP and -EINVAL using the same rules as pin_config_get.
  * @pin_config_group_set: configure all pins in a group
- * @pin_config_dbg_parse_modify: optional debugfs to modify a pin configuration
  * @pin_config_dbg_show: optional debugfs display hook that will provide
  *	per-device info for a certain pin in debugfs
  * @pin_config_group_dbg_show: optional debugfs display hook that will provide
@@ -55,9 +54,6 @@ struct pinconf_ops {
 				     unsigned selector,
 				     unsigned long *configs,
 				     unsigned num_configs);
-	int (*pin_config_dbg_parse_modify) (struct pinctrl_dev *pctldev,
-					   const char *arg,
-					   unsigned long *config);
 	void (*pin_config_dbg_show) (struct pinctrl_dev *pctldev,
 				     struct seq_file *s,
 				     unsigned offset);
-- 
2.20.1

