Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A26C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AAA20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dvtb2b+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95AAA20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbeGYRXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:23:07 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43950 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbeGYRXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:23:07 -0400
Received: by mail-pl0-f67.google.com with SMTP id x6-v6so1804577plv.10;
        Wed, 25 Jul 2018 09:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jsoTncve91oTeIgFCAwDLDcXYqpvmXypBQrtnl9aTtk=;
        b=Dvtb2b+OyxjZlFIfyormJS/QuvWGWWducOdKo65e+AbZjj0kdHN6+X6voouL/ynKnq
         9XQKrCDqM69IpShCz9jpi1523JTn9pdnJDYwbVmL3kxYEOgIWneWj6IK2pzdGB4ajx7m
         qxR4b710ItYndt0cIJuB9eZ344/tEkxg3g5+iIaEkx3cTmCJ5ZAPmWQTEjjetfNfCQvw
         +6ONQmDguNMYH/dtUD0e53UfcbvdFzMddtaMHLWOXVPYuuAcOtIB3zRrSwvDqTv8sVpX
         N2dLwOhyiN2AAkqiX5gQ61/gWdbty+/1FoUN4zp1TvyEm9KY0jLQdDvNLmNNAQC7k5wm
         UlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jsoTncve91oTeIgFCAwDLDcXYqpvmXypBQrtnl9aTtk=;
        b=RECJHZLZsg7nBt0eRkoei4e3vFuz3UVncFyipn4tk6U3+VeqoF3gx1CkirEqdV1ur0
         V83HBOfzrtk7zMNTIvmH6GBlSoPEYelX3LH2it65Sskhqd9oSwmSuVe4xfVKit8xNOso
         lQbXN5sjK8Son1buitWnRd7xIYivCxJ6kluKT0Kqi69eMYDH6o2+ryeHRVBFy6f2yjm0
         orcQcgfcZ/M0oFYBclEFx+RpF6SlJDDex9heoDAD7slz9F/eMw/AGcEw8rfqtnDtIBiZ
         azjjDiTzwR2euoZPgn/OpIiQTELkVPJy21T9JWi50GqePMWufaDbO7XhsV1l2vtlBCNw
         uDjQ==
X-Gm-Message-State: AOUpUlGyWswp9OmmVFRP6ks4IHHpQW5rpH4ERhlTw/jcxP+bjr4Julnl
        gltDEkdOIAMAduyNokte6MK830mF
X-Google-Smtp-Source: AAOMgpdfvPNNvEsl1AgglmIWC4AC6Jz0Baa97Ra3DkWXnPy+omHHUxwfWou8mDdiJ47pWzSSHvSoCQ==
X-Received: by 2002:a17:902:24c7:: with SMTP id l7-v6mr21657373plg.170.1532535046474;
        Wed, 25 Jul 2018 09:10:46 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c85-v6sm30010752pfd.110.2018.07.25.09.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 09:10:44 -0700 (PDT)
Date:   Wed, 25 Jul 2018 09:10:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        ego@linux.vnet.ibm.com, stewart@linux.ibm.com
Subject: Re: [PATCH v8 2/2] hwmon: ibmpowernv: Add attributes to
 enable/disable sensor groups
Message-ID: <20180725161042.GA20648@roeck-us.net>
References: <1532423589-18730-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1532423589-18730-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532423589-18730-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 02:43:09PM +0530, Shilpasri G Bhat wrote:
> OPAL firmware provides the facility for some groups of sensors to be
> enabled/disabled at runtime to give the user the option of using the
> system resources for collecting these sensors or not.
> 
> For example, on POWER9 systems, the On Chip Controller (OCC) gathers
> various system and chip level sensors and maintains their values in
> main memory.
> 
> This patch provides support for enabling/disabling the sensor groups
> like power, temperature, current and voltage.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> [stewart@linux.vnet.ibm.com: Commit message]

Acked-by: Guenter Roeck <linux@roeck-us.net>

I would appreciate if subsequent changes were handled as additional
patches instead of forcing me to re-review everything again from
scratch.

I would also appreciate if those requesting changes would have the
courtesy of reviewing the changes triggered by those requests.

Thanks,
Guenter

> ---
> Changes from v7:
> - Use of_for_each_phandle() and of_count_phandle_with_args() to parse
>   through the phandle array
> 
>  Documentation/hwmon/ibmpowernv |  43 +++++++-
>  drivers/hwmon/ibmpowernv.c     | 238 +++++++++++++++++++++++++++++++++++------
>  2 files changed, 247 insertions(+), 34 deletions(-)
> 
> diff --git a/Documentation/hwmon/ibmpowernv b/Documentation/hwmon/ibmpowernv
> index 8826ba2..5646825 100644
> --- a/Documentation/hwmon/ibmpowernv
> +++ b/Documentation/hwmon/ibmpowernv
> @@ -33,9 +33,48 @@ fanX_input		Measured RPM value.
>  fanX_min		Threshold RPM for alert generation.
>  fanX_fault		0: No fail condition
>  			1: Failing fan
> +
>  tempX_input		Measured ambient temperature.
>  tempX_max		Threshold ambient temperature for alert generation.
> -inX_input		Measured power supply voltage
> +tempX_highest		Historical maximum temperature
> +tempX_lowest		Historical minimum temperature
> +tempX_enable		Enable/disable all temperature sensors belonging to the
> +			sub-group. In POWER9, this attribute corresponds to
> +			each OCC. Using this attribute each OCC can be asked to
> +			disable/enable all of its temperature sensors.
> +			1: Enable
> +			0: Disable
> +
> +inX_input		Measured power supply voltage (millivolt)
>  inX_fault		0: No fail condition.
>  			1: Failing power supply.
> -power1_input		System power consumption (microWatt)
> +inX_highest		Historical maximum voltage
> +inX_lowest		Historical minimum voltage
> +inX_enable		Enable/disable all voltage sensors belonging to the
> +			sub-group. In POWER9, this attribute corresponds to
> +			each OCC. Using this attribute each OCC can be asked to
> +			disable/enable all of its voltage sensors.
> +			1: Enable
> +			0: Disable
> +
> +powerX_input		Power consumption (microWatt)
> +powerX_input_highest	Historical maximum power
> +powerX_input_lowest	Historical minimum power
> +powerX_enable		Enable/disable all power sensors belonging to the
> +			sub-group. In POWER9, this attribute corresponds to
> +			each OCC. Using this attribute each OCC can be asked to
> +			disable/enable all of its power sensors.
> +			1: Enable
> +			0: Disable
> +
> +currX_input		Measured current (milliampere)
> +currX_highest		Historical maximum current
> +currX_lowest		Historical minimum current
> +currX_enable		Enable/disable all current sensors belonging to the
> +			sub-group. In POWER9, this attribute corresponds to
> +			each OCC. Using this attribute each OCC can be asked to
> +			disable/enable all of its current sensors.
> +			1: Enable
> +			0: Disable
> +
> +energyX_input		Cumulative energy (microJoule)
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index f829dad..8347280 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -90,11 +90,20 @@ struct sensor_data {
>  	char label[MAX_LABEL_LEN];
>  	char name[MAX_ATTR_LEN];
>  	struct device_attribute dev_attr;
> +	struct sensor_group_data *sgrp_data;
> +};
> +
> +struct sensor_group_data {
> +	struct mutex mutex;
> +	u32 gid;
> +	bool enable;
>  };
>  
>  struct platform_data {
>  	const struct attribute_group *attr_groups[MAX_SENSOR_TYPE + 1];
> +	struct sensor_group_data *sgrp_data;
>  	u32 sensors_count; /* Total count of sensors from each group */
> +	u32 nr_sensor_groups; /* Total number of sensor groups */
>  };
>  
>  static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
> @@ -105,6 +114,9 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
>  	ssize_t ret;
>  	u64 x;
>  
> +	if (sdata->sgrp_data && !sdata->sgrp_data->enable)
> +		return -ENODATA;
> +
>  	ret =  opal_get_sensor_data_u64(sdata->id, &x);
>  
>  	if (ret)
> @@ -120,6 +132,46 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
>  	return sprintf(buf, "%llu\n", x);
>  }
>  
> +static ssize_t show_enable(struct device *dev,
> +			   struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_data *sdata = container_of(devattr, struct sensor_data,
> +						 dev_attr);
> +
> +	return sprintf(buf, "%u\n", sdata->sgrp_data->enable);
> +}
> +
> +static ssize_t store_enable(struct device *dev,
> +			    struct device_attribute *devattr,
> +			    const char *buf, size_t count)
> +{
> +	struct sensor_data *sdata = container_of(devattr, struct sensor_data,
> +						 dev_attr);
> +	struct sensor_group_data *sgrp_data = sdata->sgrp_data;
> +	int ret;
> +	bool data;
> +
> +	ret = kstrtobool(buf, &data);
> +	if (ret)
> +		return ret;
> +
> +	ret = mutex_lock_interruptible(&sgrp_data->mutex);
> +	if (ret)
> +		return ret;
> +
> +	if (data != sgrp_data->enable) {
> +		ret =  sensor_group_enable(sgrp_data->gid, data);
> +		if (!ret)
> +			sgrp_data->enable = data;
> +	}
> +
> +	if (!ret)
> +		ret = count;
> +
> +	mutex_unlock(&sgrp_data->mutex);
> +	return ret;
> +}
> +
>  static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
>  			  char *buf)
>  {
> @@ -292,12 +344,115 @@ static u32 get_sensor_hwmon_index(struct sensor_data *sdata,
>  	return ++sensor_groups[sdata->type].hwmon_index;
>  }
>  
> +static int init_sensor_group_data(struct platform_device *pdev,
> +				  struct platform_data *pdata)
> +{
> +	struct sensor_group_data *sgrp_data;
> +	struct device_node *groups, *sgrp;
> +	int count = 0, ret = 0;
> +	enum sensors type;
> +
> +	groups = of_find_compatible_node(NULL, NULL, "ibm,opal-sensor-group");
> +	if (!groups)
> +		return ret;
> +
> +	for_each_child_of_node(groups, sgrp) {
> +		type = get_sensor_type(sgrp);
> +		if (type != MAX_SENSOR_TYPE)
> +			pdata->nr_sensor_groups++;
> +	}
> +
> +	if (!pdata->nr_sensor_groups)
> +		goto out;
> +
> +	sgrp_data = devm_kcalloc(&pdev->dev, pdata->nr_sensor_groups,
> +				 sizeof(*sgrp_data), GFP_KERNEL);
> +	if (!sgrp_data) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	for_each_child_of_node(groups, sgrp) {
> +		u32 gid;
> +
> +		type = get_sensor_type(sgrp);
> +		if (type == MAX_SENSOR_TYPE)
> +			continue;
> +
> +		if (of_property_read_u32(sgrp, "sensor-group-id", &gid))
> +			continue;
> +
> +		if (of_count_phandle_with_args(sgrp, "sensors", NULL) <= 0)
> +			continue;
> +
> +		sensor_groups[type].attr_count++;
> +		sgrp_data[count].gid = gid;
> +		mutex_init(&sgrp_data[count].mutex);
> +		sgrp_data[count++].enable = false;
> +	}
> +
> +	pdata->sgrp_data = sgrp_data;
> +out:
> +	of_node_put(groups);
> +	return ret;
> +}
> +
> +static struct sensor_group_data *get_sensor_group(struct platform_data *pdata,
> +						  struct device_node *node,
> +						  enum sensors gtype)
> +{
> +	struct sensor_group_data *sgrp_data = pdata->sgrp_data;
> +	struct device_node *groups, *sgrp;
> +
> +	groups = of_find_compatible_node(NULL, NULL, "ibm,opal-sensor-group");
> +	if (!groups)
> +		return NULL;
> +
> +	for_each_child_of_node(groups, sgrp) {
> +		struct of_phandle_iterator it;
> +		u32 gid;
> +		int rc, i;
> +		enum sensors type;
> +
> +		type = get_sensor_type(sgrp);
> +		if (type != gtype)
> +			continue;
> +
> +		if (of_property_read_u32(sgrp, "sensor-group-id", &gid))
> +			continue;
> +
> +		of_for_each_phandle(&it, rc, sgrp, "sensors", NULL, 0)
> +			if (it.phandle == node->phandle) {
> +				of_node_put(it.node);
> +				break;
> +			}
> +
> +		if (rc)
> +			continue;
> +
> +		for (i = 0; i < pdata->nr_sensor_groups; i++)
> +			if (gid == sgrp_data[i].gid) {
> +				of_node_put(sgrp);
> +				of_node_put(groups);
> +				return &sgrp_data[i];
> +			}
> +	}
> +
> +	of_node_put(groups);
> +	return NULL;
> +}
> +
>  static int populate_attr_groups(struct platform_device *pdev)
>  {
>  	struct platform_data *pdata = platform_get_drvdata(pdev);
>  	const struct attribute_group **pgroups = pdata->attr_groups;
>  	struct device_node *opal, *np;
>  	enum sensors type;
> +	int ret;
> +
> +	ret = init_sensor_group_data(pdev, pdata);
> +	if (ret)
> +		return ret;
>  
>  	opal = of_find_node_by_path("/ibm,opal/sensors");
>  	for_each_child_of_node(opal, np) {
> @@ -344,7 +499,10 @@ static int populate_attr_groups(struct platform_device *pdev)
>  static void create_hwmon_attr(struct sensor_data *sdata, const char *attr_name,
>  			      ssize_t (*show)(struct device *dev,
>  					      struct device_attribute *attr,
> -					      char *buf))
> +					      char *buf),
> +			    ssize_t (*store)(struct device *dev,
> +					     struct device_attribute *attr,
> +					     const char *buf, size_t count))
>  {
>  	snprintf(sdata->name, MAX_ATTR_LEN, "%s%d_%s",
>  		 sensor_groups[sdata->type].name, sdata->hwmon_index,
> @@ -352,23 +510,33 @@ static void create_hwmon_attr(struct sensor_data *sdata, const char *attr_name,
>  
>  	sysfs_attr_init(&sdata->dev_attr.attr);
>  	sdata->dev_attr.attr.name = sdata->name;
> -	sdata->dev_attr.attr.mode = S_IRUGO;
>  	sdata->dev_attr.show = show;
> +	if (store) {
> +		sdata->dev_attr.store = store;
> +		sdata->dev_attr.attr.mode = 0664;
> +	} else {
> +		sdata->dev_attr.attr.mode = 0444;
> +	}
>  }
>  
>  static void populate_sensor(struct sensor_data *sdata, int od, int hd, int sid,
>  			    const char *attr_name, enum sensors type,
>  			    const struct attribute_group *pgroup,
> +			    struct sensor_group_data *sgrp_data,
>  			    ssize_t (*show)(struct device *dev,
>  					    struct device_attribute *attr,
> -					    char *buf))
> +					    char *buf),
> +			    ssize_t (*store)(struct device *dev,
> +					     struct device_attribute *attr,
> +					     const char *buf, size_t count))
>  {
>  	sdata->id = sid;
>  	sdata->type = type;
>  	sdata->opal_index = od;
>  	sdata->hwmon_index = hd;
> -	create_hwmon_attr(sdata, attr_name, show);
> +	create_hwmon_attr(sdata, attr_name, show, store);
>  	pgroup->attrs[sensor_groups[type].attr_count++] = &sdata->dev_attr.attr;
> +	sdata->sgrp_data = sgrp_data;
>  }
>  
>  static char *get_max_attr(enum sensors type)
> @@ -403,24 +571,23 @@ static int create_device_attrs(struct platform_device *pdev)
>  	const struct attribute_group **pgroups = pdata->attr_groups;
>  	struct device_node *opal, *np;
>  	struct sensor_data *sdata;
> -	u32 sensor_id;
> -	enum sensors type;
>  	u32 count = 0;
> -	int err = 0;
> +	u32 group_attr_id[MAX_SENSOR_TYPE] = {0};
>  
> -	opal = of_find_node_by_path("/ibm,opal/sensors");
>  	sdata = devm_kcalloc(&pdev->dev,
>  			     pdata->sensors_count, sizeof(*sdata),
>  			     GFP_KERNEL);
> -	if (!sdata) {
> -		err = -ENOMEM;
> -		goto exit_put_node;
> -	}
> +	if (!sdata)
> +		return -ENOMEM;
>  
> +	opal = of_find_node_by_path("/ibm,opal/sensors");
>  	for_each_child_of_node(opal, np) {
> +		struct sensor_group_data *sgrp_data;
>  		const char *attr_name;
> -		u32 opal_index;
> +		u32 opal_index, hw_id;
> +		u32 sensor_id;
>  		const char *label;
> +		enum sensors type;
>  
>  		if (np->name == NULL)
>  			continue;
> @@ -456,14 +623,12 @@ static int create_device_attrs(struct platform_device *pdev)
>  			opal_index = INVALID_INDEX;
>  		}
>  
> -		sdata[count].opal_index = opal_index;
> -		sdata[count].hwmon_index =
> -			get_sensor_hwmon_index(&sdata[count], sdata, count);
> -
> -		create_hwmon_attr(&sdata[count], attr_name, show_sensor);
> -
> -		pgroups[type]->attrs[sensor_groups[type].attr_count++] =
> -				&sdata[count++].dev_attr.attr;
> +		hw_id = get_sensor_hwmon_index(&sdata[count], sdata, count);
> +		sgrp_data = get_sensor_group(pdata, np, type);
> +		populate_sensor(&sdata[count], opal_index, hw_id, sensor_id,
> +				attr_name, type, pgroups[type], sgrp_data,
> +				show_sensor, NULL);
> +		count++;
>  
>  		if (!of_property_read_string(np, "label", &label)) {
>  			/*
> @@ -474,35 +639,43 @@ static int create_device_attrs(struct platform_device *pdev)
>  			 */
>  
>  			make_sensor_label(np, &sdata[count], label);
> -			populate_sensor(&sdata[count], opal_index,
> -					sdata[count - 1].hwmon_index,
> +			populate_sensor(&sdata[count], opal_index, hw_id,
>  					sensor_id, "label", type, pgroups[type],
> -					show_label);
> +					NULL, show_label, NULL);
>  			count++;
>  		}
>  
>  		if (!of_property_read_u32(np, "sensor-data-max", &sensor_id)) {
>  			attr_name = get_max_attr(type);
> -			populate_sensor(&sdata[count], opal_index,
> -					sdata[count - 1].hwmon_index,
> +			populate_sensor(&sdata[count], opal_index, hw_id,
>  					sensor_id, attr_name, type,
> -					pgroups[type], show_sensor);
> +					pgroups[type], sgrp_data, show_sensor,
> +					NULL);
>  			count++;
>  		}
>  
>  		if (!of_property_read_u32(np, "sensor-data-min", &sensor_id)) {
>  			attr_name = get_min_attr(type);
> -			populate_sensor(&sdata[count], opal_index,
> -					sdata[count - 1].hwmon_index,
> +			populate_sensor(&sdata[count], opal_index, hw_id,
>  					sensor_id, attr_name, type,
> -					pgroups[type], show_sensor);
> +					pgroups[type], sgrp_data, show_sensor,
> +					NULL);
> +			count++;
> +		}
> +
> +		if (sgrp_data && !sgrp_data->enable) {
> +			sgrp_data->enable = true;
> +			hw_id = ++group_attr_id[type];
> +			populate_sensor(&sdata[count], opal_index, hw_id,
> +					sgrp_data->gid, "enable", type,
> +					pgroups[type], sgrp_data, show_enable,
> +					store_enable);
>  			count++;
>  		}
>  	}
>  
> -exit_put_node:
>  	of_node_put(opal);
> -	return err;
> +	return 0;
>  }
>  
>  static int ibmpowernv_probe(struct platform_device *pdev)
> @@ -517,6 +690,7 @@ static int ibmpowernv_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pdata);
>  	pdata->sensors_count = 0;
> +	pdata->nr_sensor_groups = 0;
>  	err = populate_attr_groups(pdev);
>  	if (err)
>  		return err;
> -- 
> 1.8.3.1
> 
