Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FFFC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04D32189C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04D32189C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbeGDOMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:12:43 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:52246 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752214AbeGDOMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:12:42 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 4 Jul 2018 17:15:29 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (dev-l-vrt-136.mtl.labs.mlnx [10.134.136.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id w64ECdvQ026656;
        Wed, 4 Jul 2018 17:12:39 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id w64ECdi4023098;
        Wed, 4 Jul 2018 17:12:39 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id w64ECYcl023096;
        Wed, 4 Jul 2018 17:12:34 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH iproute2/net-next] devlink: Add param command support
Date:   Wed,  4 Jul 2018 17:12:06 +0300
Message-Id: <1530713526-23028-1-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
References: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for configuration parameters set and show.
Each parameter can be either generic or driver-specific.
The user can retrieve data on these configuration parameters by devlink
param show command and can set new value to a configuration parameter
by devlink param set command.
The configuration parameters can be set in different configuration
modes:
  runtime - set while driver is running, no reset required.
  driverinit - applied while driver initializes, requires restart
               driver by devlink reload command.
  permanent - written to device's non-volatile memory, hard reset
              required to apply.

New commands added:
  devlink dev param show [DEV name PARAMETER]
  devlink dev param set DEV name PARAMETER value VALUE
			    cmode { permanent | driverinit | runtime }

Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
---
 devlink/devlink.c            | 454 +++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/devlink.h |  24 +++
 man/man8/devlink-dev.8       |  57 ++++++
 3 files changed, 535 insertions(+)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index df2c66d..42fa716 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -35,6 +35,10 @@
 #define ESWITCH_INLINE_MODE_NETWORK "network"
 #define ESWITCH_INLINE_MODE_TRANSPORT "transport"
 
+#define PARAM_CMODE_RUNTIME_STR "runtime"
+#define PARAM_CMODE_DRIVERINIT_STR "driverinit"
+#define PARAM_CMODE_PERMANENT_STR "permanent"
+
 static int g_new_line_count;
 
 #define pr_err(args...) fprintf(stderr, ##args)
@@ -187,6 +191,9 @@ static void ifname_map_free(struct ifname_map *ifname_map)
 #define DL_OPT_ESWITCH_ENCAP_MODE	BIT(15)
 #define DL_OPT_RESOURCE_PATH	BIT(16)
 #define DL_OPT_RESOURCE_SIZE	BIT(17)
+#define DL_OPT_PARAM_NAME	BIT(18)
+#define DL_OPT_PARAM_VALUE	BIT(19)
+#define DL_OPT_PARAM_CMODE	BIT(20)
 
 struct dl_opts {
 	uint32_t present; /* flags of present items */
@@ -211,6 +218,9 @@ struct dl_opts {
 	uint32_t resource_size;
 	uint32_t resource_id;
 	bool resource_id_valid;
+	const char *param_name;
+	const char *param_value;
+	enum devlink_param_cmode cmode;
 };
 
 struct dl {
@@ -348,6 +358,12 @@ static const enum mnl_attr_data_type devlink_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_DPIPE_FIELD_ID] = MNL_TYPE_U32,
 	[DEVLINK_ATTR_DPIPE_FIELD_BITWIDTH] = MNL_TYPE_U32,
 	[DEVLINK_ATTR_DPIPE_FIELD_MAPPING_TYPE] = MNL_TYPE_U32,
+	[DEVLINK_ATTR_PARAM] = MNL_TYPE_NESTED,
+	[DEVLINK_ATTR_PARAM_NAME] = MNL_TYPE_STRING,
+	[DEVLINK_ATTR_PARAM_TYPE] = MNL_TYPE_U8,
+	[DEVLINK_ATTR_PARAM_VALUES_LIST] = MNL_TYPE_NESTED,
+	[DEVLINK_ATTR_PARAM_VALUE] = MNL_TYPE_NESTED,
+	[DEVLINK_ATTR_PARAM_VALUE_CMODE] = MNL_TYPE_U8,
 };
 
 static int attr_cb(const struct nlattr *attr, void *data)
@@ -514,6 +530,34 @@ static int strtouint16_t(const char *str, uint16_t *p_val)
 	return 0;
 }
 
+static int strtouint8_t(const char *str, uint8_t *p_val)
+{
+	char *endptr;
+	unsigned long int val;
+
+	val = strtoul(str, &endptr, 10);
+	if (endptr == str || *endptr != '\0')
+		return -EINVAL;
+	if (val > UCHAR_MAX)
+		return -ERANGE;
+	*p_val = val;
+	return 0;
+}
+
+static int strtobool(const char *str, bool *p_val)
+{
+	bool val;
+
+	if (!strcmp(str, "true") || !strcmp(str, "1"))
+		val = true;
+	else if (!strcmp(str, "false") || !strcmp(str, "0"))
+		val = false;
+	else
+		return -EINVAL;
+	*p_val = val;
+	return 0;
+}
+
 static int __dl_argv_handle(char *str, char **p_bus_name, char **p_dev_name)
 {
 	strslashrsplit(str, p_bus_name, p_dev_name);
@@ -792,6 +836,22 @@ static int eswitch_encap_mode_get(const char *typestr, bool *p_mode)
 	return 0;
 }
 
+static int param_cmode_get(const char *cmodestr,
+			   enum devlink_param_cmode *cmode)
+{
+	if (strcmp(cmodestr, PARAM_CMODE_RUNTIME_STR) == 0) {
+		*cmode = DEVLINK_PARAM_CMODE_RUNTIME;
+	} else if (strcmp(cmodestr, PARAM_CMODE_DRIVERINIT_STR) == 0) {
+		*cmode = DEVLINK_PARAM_CMODE_DRIVERINIT;
+	} else if (strcmp(cmodestr, PARAM_CMODE_PERMANENT_STR) == 0) {
+		*cmode = DEVLINK_PARAM_CMODE_PERMANENT;
+	} else {
+		pr_err("Unknown configuration mode \"%s\"\n", cmodestr);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int dl_argv_parse(struct dl *dl, uint32_t o_required,
 			 uint32_t o_optional)
 {
@@ -973,6 +1033,32 @@ static int dl_argv_parse(struct dl *dl, uint32_t o_required,
 			if (err)
 				return err;
 			o_found |= DL_OPT_RESOURCE_SIZE;
+		} else if (dl_argv_match(dl, "name") &&
+			   (o_all & DL_OPT_PARAM_NAME)) {
+			dl_arg_inc(dl);
+			err = dl_argv_str(dl, &opts->param_name);
+			if (err)
+				return err;
+			o_found |= DL_OPT_PARAM_NAME;
+		} else if (dl_argv_match(dl, "value") &&
+			   (o_all & DL_OPT_PARAM_VALUE)) {
+			dl_arg_inc(dl);
+			err = dl_argv_str(dl, &opts->param_value);
+			if (err)
+				return err;
+			o_found |= DL_OPT_PARAM_VALUE;
+		} else if (dl_argv_match(dl, "cmode") &&
+			   (o_all & DL_OPT_PARAM_CMODE)) {
+			const char *cmodestr;
+
+			dl_arg_inc(dl);
+			err = dl_argv_str(dl, &cmodestr);
+			if (err)
+				return err;
+			err = param_cmode_get(cmodestr, &opts->cmode);
+			if (err)
+				return err;
+			o_found |= DL_OPT_PARAM_CMODE;
 		} else {
 			pr_err("Unknown option \"%s\"\n", dl_argv(dl));
 			return -EINVAL;
@@ -1057,6 +1143,24 @@ static int dl_argv_parse(struct dl *dl, uint32_t o_required,
 		return -EINVAL;
 	}
 
+	if ((o_required & DL_OPT_PARAM_NAME) &&
+	    !(o_found & DL_OPT_PARAM_NAME)) {
+		pr_err("Parameter name expected.\n");
+		return -EINVAL;
+	}
+
+	if ((o_required & DL_OPT_PARAM_VALUE) &&
+	    !(o_found & DL_OPT_PARAM_VALUE)) {
+		pr_err("Value to set expected.\n");
+		return -EINVAL;
+	}
+
+	if ((o_required & DL_OPT_PARAM_CMODE) &&
+	    !(o_found & DL_OPT_PARAM_CMODE)) {
+		pr_err("Configuration mode expected.\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -1121,6 +1225,12 @@ static void dl_opts_put(struct nlmsghdr *nlh, struct dl *dl)
 	if (opts->present & DL_OPT_RESOURCE_SIZE)
 		mnl_attr_put_u64(nlh, DEVLINK_ATTR_RESOURCE_SIZE,
 				 opts->resource_size);
+	if (opts->present & DL_OPT_PARAM_NAME)
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_NAME,
+				  opts->param_name);
+	if (opts->present & DL_OPT_PARAM_CMODE)
+		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_CMODE,
+				opts->cmode);
 }
 
 static int dl_argv_parse_put(struct nlmsghdr *nlh, struct dl *dl,
@@ -1179,6 +1289,8 @@ static void cmd_dev_help(void)
 	pr_err("                               [ inline-mode { none | link | network | transport } ]\n");
 	pr_err("                               [ encap { disable | enable } ]\n");
 	pr_err("       devlink dev eswitch show DEV\n");
+	pr_err("       devlink dev param set DEV name PARAMETER value VALUE cmode { permanent | driverinit | runtime }\n");
+	pr_err("       devlink dev param show [DEV name PARAMETER]\n");
 	pr_err("       devlink dev reload DEV\n");
 }
 
@@ -1393,6 +1505,14 @@ static void pr_out_str(struct dl *dl, const char *name, const char *val)
 	}
 }
 
+static void pr_out_bool(struct dl *dl, const char *name, bool val)
+{
+	if (val)
+		pr_out_str(dl, name, "true");
+	else
+		pr_out_str(dl, name, "false");
+}
+
 static void pr_out_uint(struct dl *dl, const char *name, unsigned int val)
 {
 	if (dl->json_output) {
@@ -1475,6 +1595,19 @@ static void pr_out_entry_end(struct dl *dl)
 		__pr_out_newline();
 }
 
+static const char *param_cmode_name(uint8_t cmode)
+{
+	switch (cmode) {
+	case DEVLINK_PARAM_CMODE_RUNTIME:
+		return PARAM_CMODE_RUNTIME_STR;
+	case DEVLINK_PARAM_CMODE_DRIVERINIT:
+		return PARAM_CMODE_DRIVERINIT_STR;
+	case DEVLINK_PARAM_CMODE_PERMANENT:
+		return PARAM_CMODE_PERMANENT_STR;
+	default: return "<unknown type>";
+	}
+}
+
 static const char *eswitch_mode_name(uint32_t mode)
 {
 	switch (mode) {
@@ -1593,6 +1726,304 @@ static int cmd_dev_eswitch(struct dl *dl)
 	return -ENOENT;
 }
 
+static void pr_out_param_value(struct dl *dl, int nla_type, struct nlattr *nl)
+{
+	struct nlattr *nla_value[DEVLINK_ATTR_MAX + 1] = {};
+	struct nlattr *val_attr;
+	int err;
+
+	err = mnl_attr_parse_nested(nl, attr_cb, nla_value);
+	if (err != MNL_CB_OK)
+		return;
+
+	if (!nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE] ||
+	    (nla_type != MNL_TYPE_FLAG &&
+	     !nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA]))
+		return;
+
+	pr_out_str(dl, "cmode",
+		   param_cmode_name(mnl_attr_get_u8(nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE])));
+	val_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA];
+
+	switch (nla_type) {
+	case MNL_TYPE_U8:
+		pr_out_uint(dl, "value", mnl_attr_get_u8(val_attr));
+		break;
+	case MNL_TYPE_U16:
+		pr_out_uint(dl, "value", mnl_attr_get_u16(val_attr));
+		break;
+	case MNL_TYPE_U32:
+		pr_out_uint(dl, "value", mnl_attr_get_u32(val_attr));
+		break;
+	case MNL_TYPE_STRING:
+		pr_out_str(dl, "value", mnl_attr_get_str(val_attr));
+		break;
+	case MNL_TYPE_FLAG:
+		pr_out_bool(dl, "value", val_attr ? true : false);
+		break;
+	}
+}
+
+static void pr_out_param(struct dl *dl, struct nlattr **tb, bool array)
+{
+	struct nlattr *nla_param[DEVLINK_ATTR_MAX + 1] = {};
+	struct nlattr *param_value_attr;
+	int nla_type;
+	int err;
+
+	err = mnl_attr_parse_nested(tb[DEVLINK_ATTR_PARAM], attr_cb, nla_param);
+	if (err != MNL_CB_OK)
+		return;
+	if (!nla_param[DEVLINK_ATTR_PARAM_NAME] ||
+	    !nla_param[DEVLINK_ATTR_PARAM_TYPE] ||
+	    !nla_param[DEVLINK_ATTR_PARAM_VALUES_LIST])
+		return;
+
+	if (array)
+		pr_out_handle_start_arr(dl, tb);
+	else
+		__pr_out_handle_start(dl, tb, true, false);
+
+	nla_type = mnl_attr_get_u8(nla_param[DEVLINK_ATTR_PARAM_TYPE]);
+
+	pr_out_str(dl, "name",
+		   mnl_attr_get_str(nla_param[DEVLINK_ATTR_PARAM_NAME]));
+
+	if (!nla_param[DEVLINK_ATTR_PARAM_GENERIC])
+		pr_out_str(dl, "type", "driver-specific");
+	else
+		pr_out_str(dl, "type", "generic");
+
+	pr_out_array_start(dl, "values");
+	mnl_attr_for_each_nested(param_value_attr,
+				 nla_param[DEVLINK_ATTR_PARAM_VALUES_LIST]) {
+		pr_out_entry_start(dl);
+		pr_out_param_value(dl, nla_type, param_value_attr);
+		pr_out_entry_end(dl);
+	}
+	pr_out_array_end(dl);
+	pr_out_handle_end(dl);
+}
+
+static int cmd_dev_param_show_cb(const struct nlmsghdr *nlh, void *data)
+{
+	struct genlmsghdr *genl = mnl_nlmsg_get_payload(nlh);
+	struct nlattr *tb[DEVLINK_ATTR_MAX + 1] = {};
+	struct dl *dl = data;
+
+	mnl_attr_parse(nlh, sizeof(*genl), attr_cb, tb);
+	if (!tb[DEVLINK_ATTR_BUS_NAME] || !tb[DEVLINK_ATTR_DEV_NAME] ||
+	    !tb[DEVLINK_ATTR_PARAM])
+		return MNL_CB_ERROR;
+	pr_out_param(dl, tb, true);
+	return MNL_CB_OK;
+}
+
+struct param_ctx {
+	struct dl *dl;
+	int nla_type;
+	union {
+		uint8_t vu8;
+		uint16_t vu16;
+		uint32_t vu32;
+		const char *vstr;
+		bool vbool;
+	} value;
+};
+
+static int cmd_dev_param_set_cb(const struct nlmsghdr *nlh, void *data)
+{
+	struct genlmsghdr *genl = mnl_nlmsg_get_payload(nlh);
+	struct nlattr *nla_param[DEVLINK_ATTR_MAX + 1] = {};
+	struct nlattr *tb[DEVLINK_ATTR_MAX + 1] = {};
+	struct nlattr *param_value_attr;
+	enum devlink_param_cmode cmode;
+	struct param_ctx *ctx = data;
+	struct dl *dl = ctx->dl;
+	int nla_type;
+	int err;
+
+	mnl_attr_parse(nlh, sizeof(*genl), attr_cb, tb);
+	if (!tb[DEVLINK_ATTR_BUS_NAME] || !tb[DEVLINK_ATTR_DEV_NAME] ||
+	    !tb[DEVLINK_ATTR_PARAM])
+		return MNL_CB_ERROR;
+
+	err = mnl_attr_parse_nested(tb[DEVLINK_ATTR_PARAM], attr_cb, nla_param);
+	if (err != MNL_CB_OK)
+		return MNL_CB_ERROR;
+
+	if (!nla_param[DEVLINK_ATTR_PARAM_TYPE] ||
+	    !nla_param[DEVLINK_ATTR_PARAM_VALUES_LIST])
+		return MNL_CB_ERROR;
+
+	nla_type = mnl_attr_get_u8(nla_param[DEVLINK_ATTR_PARAM_TYPE]);
+	mnl_attr_for_each_nested(param_value_attr,
+				 nla_param[DEVLINK_ATTR_PARAM_VALUES_LIST]) {
+		struct nlattr *nla_value[DEVLINK_ATTR_MAX + 1] = {};
+		struct nlattr *val_attr;
+
+		err = mnl_attr_parse_nested(param_value_attr,
+					    attr_cb, nla_value);
+		if (err != MNL_CB_OK)
+			return MNL_CB_ERROR;
+
+		if (!nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE] ||
+		    (nla_type != MNL_TYPE_FLAG &&
+		     !nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA]))
+			return MNL_CB_ERROR;
+
+		cmode = mnl_attr_get_u8(nla_value[DEVLINK_ATTR_PARAM_VALUE_CMODE]);
+		if (cmode == dl->opts.cmode) {
+			val_attr = nla_value[DEVLINK_ATTR_PARAM_VALUE_DATA];
+			switch (nla_type) {
+			case MNL_TYPE_U8:
+				ctx->value.vu8 = mnl_attr_get_u8(val_attr);
+				break;
+			case MNL_TYPE_U16:
+				ctx->value.vu16 = mnl_attr_get_u16(val_attr);
+				break;
+			case MNL_TYPE_U32:
+				ctx->value.vu32 = mnl_attr_get_u32(val_attr);
+				break;
+			case MNL_TYPE_STRING:
+				ctx->value.vstr = mnl_attr_get_str(val_attr);
+				break;
+			case MNL_TYPE_FLAG:
+				ctx->value.vbool = val_attr ? true : false;
+				break;
+			}
+			break;
+		}
+	}
+	ctx->nla_type = nla_type;
+	return MNL_CB_OK;
+}
+
+static int cmd_dev_param_set(struct dl *dl)
+{
+	struct param_ctx ctx = {};
+	struct nlmsghdr *nlh;
+	uint32_t val_u32;
+	uint16_t val_u16;
+	uint8_t val_u8;
+	bool val_bool;
+	int err;
+
+	err = dl_argv_parse(dl, DL_OPT_HANDLE |
+			    DL_OPT_PARAM_NAME |
+			    DL_OPT_PARAM_VALUE |
+			    DL_OPT_PARAM_CMODE, 0);
+	if (err)
+		return err;
+
+	/* Get value type */
+	nlh = mnlg_msg_prepare(dl->nlg, DEVLINK_CMD_PARAM_GET,
+			       NLM_F_REQUEST | NLM_F_ACK);
+	dl_opts_put(nlh, dl);
+
+	ctx.dl = dl;
+	err = _mnlg_socket_sndrcv(dl->nlg, nlh, cmd_dev_param_set_cb, &ctx);
+	if (err)
+		return err;
+
+	nlh = mnlg_msg_prepare(dl->nlg, DEVLINK_CMD_PARAM_SET,
+			       NLM_F_REQUEST | NLM_F_ACK);
+	dl_opts_put(nlh, dl);
+
+	mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_TYPE, ctx.nla_type);
+	switch (ctx.nla_type) {
+	case MNL_TYPE_U8:
+		err = strtouint8_t(dl->opts.param_value, &val_u8);
+		if (err)
+			goto err_param_value_parse;
+		if (val_u8 == ctx.value.vu8)
+			return 0;
+		mnl_attr_put_u8(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u8);
+		break;
+	case MNL_TYPE_U16:
+		err = strtouint16_t(dl->opts.param_value, &val_u16);
+		if (err)
+			goto err_param_value_parse;
+		if (val_u16 == ctx.value.vu16)
+			return 0;
+		mnl_attr_put_u16(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u16);
+		break;
+	case MNL_TYPE_U32:
+		err = strtouint32_t(dl->opts.param_value, &val_u32);
+		if (err)
+			goto err_param_value_parse;
+		if (val_u32 == ctx.value.vu32)
+			return 0;
+		mnl_attr_put_u32(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, val_u32);
+		break;
+	case MNL_TYPE_FLAG:
+		err = strtobool(dl->opts.param_value, &val_bool);
+		if (err)
+			goto err_param_value_parse;
+		if (val_bool == ctx.value.vbool)
+			return 0;
+		if (val_bool)
+			mnl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
+				     0, NULL);
+		break;
+	case MNL_TYPE_STRING:
+		mnl_attr_put_strz(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA,
+				  dl->opts.param_value);
+		if (!strcmp(dl->opts.param_value, ctx.value.vstr))
+			return 0;
+		break;
+	default:
+		printf("Value type not supported\n");
+		return -ENOTSUP;
+	}
+	return _mnlg_socket_sndrcv(dl->nlg, nlh, NULL, NULL);
+
+err_param_value_parse:
+	pr_err("Value \"%s\" is not a number or not within range\n",
+	       dl->opts.param_value);
+	return err;
+}
+
+static int cmd_dev_param_show(struct dl *dl)
+{
+	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK;
+	struct nlmsghdr *nlh;
+	int err;
+
+	if (dl_argc(dl) == 0)
+		flags |= NLM_F_DUMP;
+
+	nlh = mnlg_msg_prepare(dl->nlg, DEVLINK_CMD_PARAM_GET, flags);
+
+	if (dl_argc(dl) > 0) {
+		err = dl_argv_parse_put(nlh, dl, DL_OPT_HANDLE |
+					DL_OPT_PARAM_NAME, 0);
+		if (err)
+			return err;
+	}
+
+	pr_out_section_start(dl, "param");
+	err = _mnlg_socket_sndrcv(dl->nlg, nlh, cmd_dev_param_show_cb, dl);
+	pr_out_section_end(dl);
+	return err;
+}
+
+static int cmd_dev_param(struct dl *dl)
+{
+	if (dl_argv_match(dl, "help")) {
+		cmd_dev_help();
+		return 0;
+	} else if (dl_argv_match(dl, "show") ||
+		   dl_argv_match(dl, "list") || dl_no_arg(dl)) {
+		dl_arg_inc(dl);
+		return cmd_dev_param_show(dl);
+	} else if (dl_argv_match(dl, "set")) {
+		dl_arg_inc(dl);
+		return cmd_dev_param_set(dl);
+	}
+	pr_err("Command \"%s\" not found\n", dl_argv(dl));
+	return -ENOENT;
+}
 static int cmd_dev_show_cb(const struct nlmsghdr *nlh, void *data)
 {
 	struct dl *dl = data;
@@ -1669,6 +2100,9 @@ static int cmd_dev(struct dl *dl)
 	} else if (dl_argv_match(dl, "reload")) {
 		dl_arg_inc(dl);
 		return cmd_dev_reload(dl);
+	} else if (dl_argv_match(dl, "param")) {
+		dl_arg_inc(dl);
+		return cmd_dev_param(dl);
 	}
 	pr_err("Command \"%s\" not found\n", dl_argv(dl));
 	return -ENOENT;
@@ -2632,6 +3066,10 @@ static const char *cmd_name(uint8_t cmd)
 	case DEVLINK_CMD_PORT_SET: return "set";
 	case DEVLINK_CMD_PORT_NEW: return "new";
 	case DEVLINK_CMD_PORT_DEL: return "del";
+	case DEVLINK_CMD_PARAM_GET: return "get";
+	case DEVLINK_CMD_PARAM_SET: return "set";
+	case DEVLINK_CMD_PARAM_NEW: return "new";
+	case DEVLINK_CMD_PARAM_DEL: return "del";
 	default: return "<unknown cmd>";
 	}
 }
@@ -2650,6 +3088,11 @@ static const char *cmd_obj(uint8_t cmd)
 	case DEVLINK_CMD_PORT_NEW:
 	case DEVLINK_CMD_PORT_DEL:
 		return "port";
+	case DEVLINK_CMD_PARAM_GET:
+	case DEVLINK_CMD_PARAM_SET:
+	case DEVLINK_CMD_PARAM_NEW:
+	case DEVLINK_CMD_PARAM_DEL:
+		return "param";
 	default: return "<unknown obj>";
 	}
 }
@@ -2706,6 +3149,17 @@ static int cmd_mon_show_cb(const struct nlmsghdr *nlh, void *data)
 		pr_out_mon_header(genl->cmd);
 		pr_out_port(dl, tb);
 		break;
+	case DEVLINK_CMD_PARAM_GET: /* fall through */
+	case DEVLINK_CMD_PARAM_SET: /* fall through */
+	case DEVLINK_CMD_PARAM_NEW: /* fall through */
+	case DEVLINK_CMD_PARAM_DEL:
+		mnl_attr_parse(nlh, sizeof(*genl), attr_cb, tb);
+		if (!tb[DEVLINK_ATTR_BUS_NAME] || !tb[DEVLINK_ATTR_DEV_NAME] ||
+		    !tb[DEVLINK_ATTR_PARAM])
+			return MNL_CB_ERROR;
+		pr_out_mon_header(genl->cmd);
+		pr_out_param(dl, tb, false);
+		break;
 	}
 	return MNL_CB_OK;
 }
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 493f71f..f7fadd7 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -78,6 +78,11 @@ enum devlink_command {
 	 */
 	DEVLINK_CMD_RELOAD,
 
+	DEVLINK_CMD_PARAM_GET,		/* can dump */
+	DEVLINK_CMD_PARAM_SET,
+	DEVLINK_CMD_PARAM_NEW,
+	DEVLINK_CMD_PARAM_DEL,
+
 	/* add new commands above here */
 	__DEVLINK_CMD_MAX,
 	DEVLINK_CMD_MAX = __DEVLINK_CMD_MAX - 1
@@ -142,6 +147,16 @@ enum devlink_port_flavour {
 				   */
 };
 
+enum devlink_param_cmode {
+	DEVLINK_PARAM_CMODE_RUNTIME,
+	DEVLINK_PARAM_CMODE_DRIVERINIT,
+	DEVLINK_PARAM_CMODE_PERMANENT,
+
+	/* Add new configuration modes above */
+	__DEVLINK_PARAM_CMODE_MAX,
+	DEVLINK_PARAM_CMODE_MAX = __DEVLINK_PARAM_CMODE_MAX - 1
+};
+
 enum devlink_attr {
 	/* don't change the order or add anything between, this is ABI! */
 	DEVLINK_ATTR_UNSPEC,
@@ -238,6 +253,15 @@ enum devlink_attr {
 	DEVLINK_ATTR_PORT_NUMBER,		/* u32 */
 	DEVLINK_ATTR_PORT_SPLIT_SUBPORT_NUMBER,	/* u32 */
 
+	DEVLINK_ATTR_PARAM,			/* nested */
+	DEVLINK_ATTR_PARAM_NAME,		/* string */
+	DEVLINK_ATTR_PARAM_GENERIC,		/* flag */
+	DEVLINK_ATTR_PARAM_TYPE,		/* u8 */
+	DEVLINK_ATTR_PARAM_VALUES_LIST,		/* nested */
+	DEVLINK_ATTR_PARAM_VALUE,		/* nested */
+	DEVLINK_ATTR_PARAM_VALUE_DATA,		/* dynamic */
+	DEVLINK_ATTR_PARAM_VALUE_CMODE,		/* u8 */
+
 	/* add new attributes above here, update the policy in devlink.c */
 
 	__DEVLINK_ATTR_MAX,
diff --git a/man/man8/devlink-dev.8 b/man/man8/devlink-dev.8
index 7c749dd..d985da1 100644
--- a/man/man8/devlink-dev.8
+++ b/man/man8/devlink-dev.8
@@ -43,6 +43,23 @@ devlink-dev \- devlink device configuration
 .IR DEV
 
 .ti -8
+.BR "devlink dev param set"
+.IR DEV
+.BR name
+.IR PARAMETER
+.BR value
+.IR VALUE
+.BR cmode " { " runtime " | " driverinit " | " permanent " } "
+
+.ti -8
+.BR "devlink dev param show"
+.RI "[ "
+.IR DEV
+.BR name
+.IR PARAMETER
+.RI "]"
+
+.ti -8
 .BR "devlink dev reload"
 .IR DEV
 
@@ -98,6 +115,36 @@ Set eswitch encapsulation support
 .I enable
 - Enable encapsulation support
 
+.SS devlink dev param set  - set new value to devlink device configuration parameter
+
+.TP
+.BI name " PARAMETER"
+Specify parameter name to set.
+
+.TP
+.BI value " VALUE"
+New value to set.
+
+.TP
+.BR cmode " { " runtime " | " driverinit " | " permanent " } "
+Configuration mode in which the new value is set.
+
+.I runtime
+- Set new value while driver is running. This configuration mode doesn't require any reset to apply the new value.
+
+.I driverinit
+- Set new value which will be applied during driver initialization. This configuration mode requires restart driver by devlink reload command to apply the new value.
+
+.I permanent
+- New value is written to device's non-volatile memory. This configuration mode requires hard reset to apply the new value.
+
+.SS devlink dev param show - display devlink device supported configuration parameters attributes
+
+.BR name
+.IR PARAMETER
+Specify parameter name to show.
+If this argument is omitted all parameters supported by devlink devices are listed.
+
 .SS devlink dev reload - perform hot reload of the driver.
 
 .PP
@@ -126,6 +173,16 @@ devlink dev eswitch set pci/0000:01:00.0 mode switchdev
 Sets the eswitch mode of specified devlink device to switchdev.
 .RE
 .PP
+devlink dev param show pci/0000:01:00.0 name max_macs
+.RS 4
+Shows the parameter max_macs attributes.
+.RE
+.PP
+devlink dev param set pci/0000:01:00.0 name internal_error_reset value true cmode runtime
+.RS 4
+Sets the parameter internal_error_reset of specified devlink device to true.
+.RE
+.PP
 devlink dev reload pci/0000:01:00.0
 .RS 4
 Performs hot reload of specified devlink device.
-- 
1.8.3.1

