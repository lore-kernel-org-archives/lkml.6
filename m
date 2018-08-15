Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7BAC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF742159F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF742159F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbeHOMoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 08:44:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727141AbeHOMoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 08:44:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 141598197039;
        Wed, 15 Aug 2018 09:52:52 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 936042166BA5;
        Wed, 15 Aug 2018 09:52:48 +0000 (UTC)
Date:   Wed, 15 Aug 2018 11:52:42 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v9 10/22] s390: vfio-ap: sysfs interfaces to configure
 adapters
Message-ID: <20180815115242.35a2a1ce.cohuck@redhat.com>
In-Reply-To: <1534196899-16987-11-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1534196899-16987-11-git-send-email-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 15 Aug 2018 09:52:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 15 Aug 2018 09:52:52 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2018 17:48:07 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> +/**
> + * assign_adapter_store
> + *
> + * @dev: the matrix device
> + * @attr: a mediated matrix device attribute
> + * @buf: a buffer containing the adapter ID (APID) to be assigned
> + * @count: the number of bytes in @buf
> + *
> + * Parses the APID from @buf and assigns it to the mediated matrix device.
> + *
> + * Returns the number of bytes processed if the APID is valid; otherwise returns
> + * an error.
> + */
> +static ssize_t assign_adapter_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	int ret = 0;

You don't need to initialize this to 0, as kstrtoul will set it in any
case.

> +	unsigned long apid;
> +	struct mdev_device *mdev = mdev_from_dev(dev);
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	unsigned long max_apid = matrix_mdev->matrix.apm_max;
> +
> +	ret = kstrtoul(buf, 0, &apid);
> +	if (ret)
> +		return ret;
> +	if (apid > max_apid)
> +		return -EINVAL;
> +
> +	/* Set the bit in the AP mask (APM) corresponding to the AP adapter
> +	 * number (APID). The bits in the mask, from most significant to least
> +	 * significant bit, correspond to APIDs 0-255.
> +	 */
> +	mutex_lock(&matrix_dev.lock);
> +
> +	ret = vfio_ap_mdev_verify_queues_reserved_for_apid(matrix_mdev, apid);

That function name really is a mouthful :) I don't have any better
suggestions, though.

> +	if (ret)
> +		goto done;
> +
> +	set_bit_inv(apid, matrix_mdev->matrix.apm);
> +
> +	ret = vfio_ap_mdev_verify_no_sharing(matrix_mdev);
> +	if (ret)
> +		goto share_err;
> +
> +	ret = count;
> +	goto done;
> +
> +share_err:
> +	clear_bit_inv(apid, matrix_mdev->matrix.apm);
> +done:
> +	mutex_unlock(&matrix_dev.lock);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_WO(assign_adapter);
> +
> +/**
> + * unassign_adapter_store
> + *
> + * @dev: the matrix device
> + * @attr: a mediated matrix device attribute
> + * @buf: a buffer containing the adapter ID (APID) to be assigned
> + * @count: the number of bytes in @buf
> + *
> + * Parses the APID from @buf and unassigns it from the mediated matrix device.
> + * The APID must be a valid value

A valid value, but not necessarily assigned, right?

> + *
> + * Returns the number of bytes processed if the APID is valid; otherwise returns
> + * an error.
> + */
> +static ssize_t unassign_adapter_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	int ret;
> +	unsigned long apid;
> +	struct mdev_device *mdev = mdev_from_dev(dev);
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +
> +	ret = kstrtoul(buf, 0, &apid);
> +	if (ret)
> +		return ret;
> +
> +	if (apid > matrix_mdev->matrix.apm_max)
> +		return -EINVAL;
> +
> +	mutex_lock(&matrix_dev.lock);
> +	clear_bit_inv((unsigned long)apid, matrix_mdev->matrix.apm);
> +	mutex_unlock(&matrix_dev.lock);
> +
> +	return count;
> +}
> +DEVICE_ATTR_WO(unassign_adapter);

In general, looks good to me.
