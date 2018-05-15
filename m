Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753942AbeEOPXD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 11:23:03 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:58365 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752319AbeEOPXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 11:23:01 -0400
Subject: Re: [PATCH v2 1/5] media: cec-notifier: Get notifier by device and
 connector name
To: Neil Armstrong <narmstrong@baylibre.com>, airlied@linux.ie,
        hans.verkuil@cisco.com, lee.jones@linaro.org, olof@lixom.net,
        seanpaul@google.com
Cc: sadolfsson@google.com, felixe@google.com, bleung@google.com,
        darekm@google.com, marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1526395342-15481-1-git-send-email-narmstrong@baylibre.com>
 <1526395342-15481-2-git-send-email-narmstrong@baylibre.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <309fa9b4-0c0b-25af-31a3-84fe5fc00743@xs4all.nl>
Date: Tue, 15 May 2018 17:22:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1526395342-15481-2-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPNjx/0/0WMbqV2ITBrCa4SvB7NHM0uiuZUwNYFSyMCyX4bTXaW4WKZUTlUaMhHcBCbhIVoO6nx+OJ9s5Ii3kpcuXi+mgh+2uQqN2nd5UWJFrHgiCemY
 +8b6d4NMG0/s1YpivU/t7hqYxkfAiNQO701UTM22QGwFx6tcn3tj4DF27TtbMnZipjXxolbPxFgd5dTA9luD4pkUn1wQdPyUaXjA5+vhV2T3GtPXwQp0sM68
 FzmPMBhrziFn4N1BZShID4f9Xs0Op+9AUMpkYBvQm3Zf2ZAkfLxRp5XYnEqLXkxTZbKaIlsMKk4qeSUdYFCRCMvQIkkevjZEFbRKWM07AbUYNg8J1dNBpHve
 rF0g/TtFRTwlNEfT6wHvTlUcK/xwJqNKviP4ZT0Rs6rUenUPqUfaxSemku74olKXpmyZtY3yJMJREs3HzKKMjjtIokBXdK2+x+NKQHVcwGnP4zdgV9AKG6Mk
 AMYRgoRs8EqO3rSlN0aHR1BRX22oqRqoyqT/hWH1+nSR8GQvBld/2mW7XYek86dsIE0dlx1PnJHI9+uFIWVNDrKPRWBBxYzKwQhwHZijVMixC0kdJPv99uUO
 p5kjI+7NMD6ByN/BrzqlduhtJM1dlpDDgkQHkzeQXfVBk1BjKW14Hsgyj1kU7YSL3EAJfOoCwCrbiFSv/KAHgx2355yRt1xwTXKFX5/wa70+TJIyTGynQKxN
 fhqimyJxtmI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2018 04:42 PM, Neil Armstrong wrote:
> In non device-tree world, we can need to get the notifier by the driver
> name directly and eventually defer probe if not yet created.
> 
> This patch adds a variant of the get function by using the device name
> instead and will not create a notifier if not yet created.
> 
> But the i915 driver exposes at least 2 HDMI connectors, this patch also
> adds the possibility to add a connector name tied to the notifier device
> to form a tuple and associate different CEC controllers for each HDMI
> connectors.

The patch looks good, but I'm curious about this paragraph above.

Was this tested with devices with more than one HDMI output? Or only on
laptops with a single physical HDMI output? If there are two or more
outputs then I guess it is the HW designer that decides with output gets
CEC support?

Regards,

	Hans

> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/media/cec/cec-notifier.c | 11 ++++++++---
>  include/media/cec-notifier.h     | 27 ++++++++++++++++++++++++---
>  2 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/cec/cec-notifier.c b/drivers/media/cec/cec-notifier.c
> index 16dffa0..dd2078b 100644
> --- a/drivers/media/cec/cec-notifier.c
> +++ b/drivers/media/cec/cec-notifier.c
> @@ -21,6 +21,7 @@ struct cec_notifier {
>  	struct list_head head;
>  	struct kref kref;
>  	struct device *dev;
> +	const char *conn;
>  	struct cec_adapter *cec_adap;
>  	void (*callback)(struct cec_adapter *adap, u16 pa);
>  
> @@ -30,13 +31,14 @@ struct cec_notifier {
>  static LIST_HEAD(cec_notifiers);
>  static DEFINE_MUTEX(cec_notifiers_lock);
>  
> -struct cec_notifier *cec_notifier_get(struct device *dev)
> +struct cec_notifier *cec_notifier_get_conn(struct device *dev, const char *conn)
>  {
>  	struct cec_notifier *n;
>  
>  	mutex_lock(&cec_notifiers_lock);
>  	list_for_each_entry(n, &cec_notifiers, head) {
> -		if (n->dev == dev) {
> +		if (n->dev == dev &&
> +		    (!conn || !strcmp(n->conn, conn))) {
>  			kref_get(&n->kref);
>  			mutex_unlock(&cec_notifiers_lock);
>  			return n;
> @@ -46,6 +48,8 @@ struct cec_notifier *cec_notifier_get(struct device *dev)
>  	if (!n)
>  		goto unlock;
>  	n->dev = dev;
> +	if (conn)
> +		n->conn = kstrdup(conn, GFP_KERNEL);
>  	n->phys_addr = CEC_PHYS_ADDR_INVALID;
>  	mutex_init(&n->lock);
>  	kref_init(&n->kref);
> @@ -54,7 +58,7 @@ struct cec_notifier *cec_notifier_get(struct device *dev)
>  	mutex_unlock(&cec_notifiers_lock);
>  	return n;
>  }
> -EXPORT_SYMBOL_GPL(cec_notifier_get);
> +EXPORT_SYMBOL_GPL(cec_notifier_get_conn);
>  
>  static void cec_notifier_release(struct kref *kref)
>  {
> @@ -62,6 +66,7 @@ static void cec_notifier_release(struct kref *kref)
>  		container_of(kref, struct cec_notifier, kref);
>  
>  	list_del(&n->head);
> +	kfree(n->conn);
>  	kfree(n);
>  }
>  
> diff --git a/include/media/cec-notifier.h b/include/media/cec-notifier.h
> index cf0add7..814eeef 100644
> --- a/include/media/cec-notifier.h
> +++ b/include/media/cec-notifier.h
> @@ -20,8 +20,10 @@ struct cec_notifier;
>  #if IS_REACHABLE(CONFIG_CEC_CORE) && IS_ENABLED(CONFIG_CEC_NOTIFIER)
>  
>  /**
> - * cec_notifier_get - find or create a new cec_notifier for the given device.
> + * cec_notifier_get_conn - find or create a new cec_notifier for the given
> + * device and connector tuple.
>   * @dev: device that sends the events.
> + * @conn: the connector name from which the event occurs
>   *
>   * If a notifier for device @dev already exists, then increase the refcount
>   * and return that notifier.
> @@ -31,7 +33,8 @@ struct cec_notifier;
>   *
>   * Return NULL if the memory could not be allocated.
>   */
> -struct cec_notifier *cec_notifier_get(struct device *dev);
> +struct cec_notifier *cec_notifier_get_conn(struct device *dev,
> +					   const char *conn);
>  
>  /**
>   * cec_notifier_put - decrease refcount and delete when the refcount reaches 0.
> @@ -85,7 +88,8 @@ void cec_register_cec_notifier(struct cec_adapter *adap,
>  			       struct cec_notifier *notifier);
>  
>  #else
> -static inline struct cec_notifier *cec_notifier_get(struct device *dev)
> +static inline struct cec_notifier *cec_notifier_get_conn(struct device *dev,
> +							 const char *conn)
>  {
>  	/* A non-NULL pointer is expected on success */
>  	return (struct cec_notifier *)0xdeadfeed;
> @@ -121,6 +125,23 @@ static inline void cec_register_cec_notifier(struct cec_adapter *adap,
>  #endif
>  
>  /**
> + * cec_notifier_get - find or create a new cec_notifier for the given device.
> + * @dev: device that sends the events.
> + *
> + * If a notifier for device @dev already exists, then increase the refcount
> + * and return that notifier.
> + *
> + * If it doesn't exist, then allocate a new notifier struct and return a
> + * pointer to that new struct.
> + *
> + * Return NULL if the memory could not be allocated.
> + */
> +static inline struct cec_notifier *cec_notifier_get(struct device *dev)
> +{
> +	return cec_notifier_get_conn(dev, NULL);
> +}
> +
> +/**
>   * cec_notifier_phys_addr_invalidate() - set the physical address to INVALID
>   *
>   * @n: the CEC notifier
> 
