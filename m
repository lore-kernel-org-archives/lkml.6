Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A4DECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02D0214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02D0214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeJQVcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:32:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:45774 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbeJQVcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:32:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 06:36:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,392,1534834800"; 
   d="diff'?scan'208";a="100000375"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 17 Oct 2018 06:36:12 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 17 Oct 2018 16:36:12 +0300
Date:   Wed, 17 Oct 2018 16:36:12 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] device property: Introducing software nodes
Message-ID: <20181017133612.GK24771@kuha.fi.intel.com>
References: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
 <20181016173244.GB230131@dtor-ws>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20181016173244.GB230131@dtor-ws>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 16, 2018 at 10:32:44AM -0700, Dmitry Torokhov wrote:
> Hi Heikki,
> 
> On Fri, Oct 12, 2018 at 02:39:29PM +0300, Heikki Krogerus wrote:
> > Hi guys,
> > 
> > To continue the discussion started by Dmitry [1], this is my proposal
> > that I mentioned in my last mail. In short, the idea is that instead
> > of trying to extend the support for the currently used struct
> > property_set, I'm proposing that we introduce a completely new,
> > independent type of fwnode, and replace the struct property_set with
> > it. I'm calling the type "software node" here.
> > 
> > The reason for a complete separation of the software nodes from the
> > generic property handling code is the need to be able to create the
> > nodes independently from the devices that they are bind to.
> 
> It would be great it you would provide an example of creating these
> sowftware property sets separately from devices. How do you tie device
> and its properties if they are not created together?

The properties are bind to the software nodes and not the devices. The
software nodes can then be bind to the devices when they are created.
This is actually exactly the same behaviour that we had with the
property_sets, the only difference being that we can bind the software
node to the device at a later stage.

> For OF we have compatibles and phandles for references, ACPI has
> HIDs and CIDs and notion of references as well. What do we use here,
> especially when software node is created in one subsystem (let's say
> drivers/platform/x86), but device is created somewhere else?

Reference usually means a handle to a node that is outside of the
direct child-parent relationship (hierarchy) for the caller device
node. That I do not support at this point. We support the node
hierarchy which allows us to "refer" the child and parent nodes, and
that is all that we need at this stage.

Support for references is in my plans. I will need that later. But
we'll do that as the next step.

> Another issue that is not clear to me: looking at the USB connector it
> seems you want to have references to fwnodes.

If by references you mean here access to the nodes outside of the
hierarchy, then you've misunderstood. I do not expect that with the
USB connectors.

> How do you resolve them when there are nodes of different class.
> I.e. how do you express software fwnode referencing ACPI or DT node
> when you are supplementing ACPI or DT description of a system with
> these custom/secondary nodes?

So references are not supported as I said, but I don't know if we can
or even want to support references to different types of fwnodes. I'm
not even sure we would ever need to refer an other type of fwnode from
software node. I mean, we should always be able to place a secondary
software node to both fwnodes.

In any case, this topic is outside the scope of this series.

And in case this was not clear, with the hierarchy, different types of
fwnode nodes are not supported. It means that software node can only
have software node parent and children.

> What about the other direction? I.e. can I have a DT system with USB
> connector and augment USB set up with static nodes? Not only
> basic/scalar properties, but links as well?
> 
> As I said, having and example of using this new code to achieve your
> goal with regard to USB connector would be awesome and clear a lot of my
> questions.

OK. I used the attached code to test these on Intel Cherry Trail
board. I'm creating two software nodes there: one for the FUSB302
controller, and one (a child of the FUSB302 node) for the connector.

The fusb302 node is assigned to the i2c client that is registered in
that driver, but the child node is left waiting. The child node has a
property called "name" with value "connector".

The fusb302 driver already requests a handle to the child node named
"connector" in its probe function which it assigns to the port device
that it registers. With the attached patch it will get the child node
also on CherryTrail boards, no changes to the Type-C drivers needed.

Here is the file listing that we see in sysfs (node3 is for FUSB302):

        % find /sys/kernel/software_nodes/ | grep -v properties
        ...
        /sys/kernel/software_nodes/node3
        /sys/kernel/software_nodes/node3/node0
        /sys/kernel/software_nodes/node3/node0/port0
        /sys/kernel/software_nodes/node3/i2c-fusb302
        ...

The node for the FUSB302 controller:

        % ls -l /sys/kernel/software_nodes/node3/
        total 0
        lrwxrwxrwx    1 root     root             0 Oct 17 12:12 i2c-fusb302 -> ../../../devices/pci0000:00/808622C1:00/i2c-0/i2c-fusb302
        drwxr-xr-x    3 root     root             0 Oct 17 12:03 node0
        drwxr-xr-x    2 root     root             0 Oct 17 12:12 properties

The node for the connector (child of node3):

        % ls -l /sys/kernel/software_nodes/node3/node0/
        total 0
        lrwxrwxrwx    1 root     root             0 Oct 17 12:12 port0 -> ../../../../devices/pci0000:00/808622C1:00/i2c-0/i2c-fusb302/typec/port0
        drwxr-xr-x    2 root     root             0 Oct 17 12:12 properties

And this is what the actual connector device directory looks like
(look at the "software_node" symlink:

        % ls -l /sys/class/typec/port0/
        total 0
        -rw-r--r--    1 root     root          4096 Oct 17 12:16 data_role
        lrwxrwxrwx    1 root     root             0 Oct 17 12:16 device -> ../../../i2c-fusb302
        -rw-r--r--    1 root     root          4096 Oct 17 12:16 port_type
        drwxr-xr-x    2 root     root             0 Oct 17 12:16 power
        -r--r--r--    1 root     root          4096 Oct 17 12:16 power_operation_mode
        -rw-r--r--    1 root     root          4096 Oct 17 12:16 power_role
        -rw-r--r--    1 root     root          4096 Oct 17 12:16 preferred_role
        lrwxrwxrwx    1 root     root             0 Oct 17 12:16 software_node -> ../../../../../../../kernel/software_nodes/node3/node0
        lrwxrwxrwx    1 root     root             0 Oct 17 12:16 subsystem -> ../../../../../../../class/typec
        -r--r--r--    1 root     root          4096 Oct 17 12:16 supported_accessory_modes
        -rw-r--r--    1 root     root          4096 Oct 17 12:03 uevent
        -r--r--r--    1 root     root          4096 Oct 17 12:16 usb_power_delivery_revision
        -r--r--r--    1 root     root          4096 Oct 17 12:16 usb_typec_revision
        -rw-r--r--    1 root     root          4096 Oct 17 12:16 vconn_source


thanks,

-- 
heikki

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="intel_cht_int33fe.diff"

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 7787c6ed9671..108ed001acf8 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -30,6 +30,8 @@ struct cht_int33fe_data {
 	struct i2c_client *max17047;
 	struct i2c_client *fusb302;
 	struct i2c_client *pi3usb30532;
+	struct fwnode_handle *port_node;
+	struct fwnode_handle *fusb302_node;
 	/* Contain a list-head must be per device */
 	struct device_connection connections[5];
 };
@@ -85,6 +87,12 @@ static const struct property_entry fusb302_props[] = {
 	{ }
 };
 
+static const struct property_entry usb_connector_props[] = {
+	PROPERTY_ENTRY_STRING("name", "connector"),
+	PROPERTY_ENTRY_STRING("data-role", "dual"),
+	{ }
+};
+
 static int cht_int33fe_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -150,6 +158,19 @@ static int cht_int33fe_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
+	/* Node for the FUSB302 controller */
+	data->fusb302_node = fwnode_create_software_node(fusb302_props, NULL);
+	if (IS_ERR(data->fusb302_node))
+		return PTR_ERR(data->fusb302_node);
+
+	/* Node for the connector (FUSB302 is the parent) */
+	data->port_node = fwnode_create_software_node(usb_connector_props,
+						      data->fusb302_node);
+	if (IS_ERR(data->port_node)) {
+		fwnode_remove_software_node(data->fusb302_node);
+		return PTR_ERR(data->port_node);
+	}
+
 	/* Work around BIOS bug, see comment on cht_int33fe_find_max17047 */
 	max17047 = cht_int33fe_find_max17047();
 	if (max17047) {
@@ -189,7 +210,7 @@ static int cht_int33fe_probe(struct i2c_client *client)
 	memset(&board_info, 0, sizeof(board_info));
 	strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
 	board_info.dev_name = "fusb302";
-	board_info.properties = fusb302_props;
+	board_info.fwnode = data->fusb302_node;
 	board_info.irq = fusb302_irq;
 
 	data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);
@@ -216,6 +237,8 @@ static int cht_int33fe_probe(struct i2c_client *client)
 		i2c_unregister_device(data->max17047);
 
 	device_connections_remove(data->connections);
+	fwnode_remove_software_node(data->port_node);
+	fwnode_remove_software_node(data->fusb302_node);
 
 	return -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
 }
@@ -230,6 +253,8 @@ static int cht_int33fe_remove(struct i2c_client *i2c)
 		i2c_unregister_device(data->max17047);
 
 	device_connections_remove(data->connections);
+	fwnode_remove_software_node(data->port_node);
+	fwnode_remove_software_node(data->fusb302_node);
 
 	return 0;
 }

--AqsLC8rIMeq19msA--
