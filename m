Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbeBVXT4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:19:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46112 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbeBVXTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:19:55 -0500
Subject: Re: [PATCH 3/9] drm/xen-front: Read driver configuration from Xen
 store
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <1519200222-20623-4-git-send-email-andr2000@gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <74f01442-2e9e-5de7-3a8d-f5c12d9e8667@oracle.com>
Date: Thu, 22 Feb 2018 18:20:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1519200222-20623-4-git-send-email-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8812 signatures=668677
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802220290
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 03:03 AM, Oleksandr Andrushchenko wrote:
> +
> +static int cfg_connector(struct xen_drm_front_info *front_info,
> +		struct xen_drm_front_cfg_connector *connector,
> +		const char *path, int index)
> +{
> +	char *connector_path;
> +
> +	connector_path = devm_kasprintf(&front_info->xb_dev->dev,
> +			GFP_KERNEL, "%s/%d", path, index);
> +	if (!connector_path)
> +		return -ENOMEM;
> +
> +	connector->xenstore_path = connector_path;
> +	if (xenbus_scanf(XBT_NIL, connector_path, XENDISPL_FIELD_RESOLUTION,
> +			"%d" XENDISPL_RESOLUTION_SEPARATOR "%d",
> +			&connector->width, &connector->height) < 0) {
> +		/* either no entry configured or wrong resolution set */
> +		connector->width = 0;
> +		connector->height = 0;

Do you also need to set connector->xenstore_path to NULL? Or maybe just
set it after xenbus_scanf() call.

-boris
