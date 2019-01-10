Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEB1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47FB214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfAJOUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:20:22 -0500
Received: from mga18.intel.com ([134.134.136.126]:42504 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbfAJOUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:20:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 06:20:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,461,1539673200"; 
   d="scan'208";a="310736479"
Received: from wliu29-mobl3.ccr.corp.intel.com ([10.249.174.142])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jan 2019 06:20:16 -0800
Message-ID: <1547130015.10666.17.camel@intel.com>
Subject: Re: [PATCH v2 02/11] thermal: add irq-mode configuration for trip
 point
From:   Zhang Rui <rui.zhang@intel.com>
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        krzk@kernel.org
Date:   Thu, 10 Jan 2019 22:20:15 +0800
In-Reply-To: <3314da31-1b8b-ec19-4aee-38d98aa8adbf@partner.samsung.com>
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
         <CGME20181107171036eucas1p13253d56b463c8f888ab8f8e418635297@eucas1p1.samsung.com>
         <1541610593-28542-3-git-send-email-l.luba@partner.samsung.com>
         <1544022595.2841.45.camel@intel.com>
         <2ac425fc-7c32-6e2f-7086-c14f85b0bbfd@partner.samsung.com>
         <3314da31-1b8b-ec19-4aee-38d98aa8adbf@partner.samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Lukasz,

On 四, 2018-12-06 at 20:55 +0100, Lukasz Luba wrote:
> 
> On 12/6/18 8:18 PM, Lukasz Luba wrote:
> > 
> > Hi Rui,
> > 
> > On 12/5/18 4:09 PM, Zhang Rui wrote:
> > > 
> > > On 三, 2018-11-07 at 18:09 +0100, Lukasz Luba wrote:
> > > > 
> > > > This patch adds support irq mode in trip point.
> > > > When that flag is set in DT, there is no need for polling
> > > > in thermal framework. Crossing the trip point will rise an IRQ.
> > > > The naming convention for tip point 'type' can be confussing
> > > > and 'passive' (whic is passive cooling) might be interpretted
> > > > wrongly.
> > > > 
> > > > This mechanism prevents from missue and adds explicit setting
> > > > for hardware which support interrupts for pre-configured
> > > > temperature
> > > > threshold.
> > > > 
> > > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > > Cc: Eduardo Valentin <edubezval@gmail.com>
> > > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > > Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> > > > ---
> > > >   drivers/thermal/of-thermal.c   | 17 +++++++++++++++++
> > > >   drivers/thermal/thermal_core.c | 10 ++++++++--
> > > >   include/linux/thermal.h        |  5 +++++
> > > >   3 files changed, 30 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-
> > > > thermal.c
> > > > index 4bfdb4a..1a75946a 100644
> > > > --- a/drivers/thermal/of-thermal.c
> > > > +++ b/drivers/thermal/of-thermal.c
> > > > @@ -312,6 +312,20 @@ static int of_thermal_get_trip_type(struct
> > > > thermal_zone_device *tz, int trip,
> > > >       return 0;
> > > >   }
> > > > +static int
> > > > +of_thermal_get_trip_irq_mode(struct thermal_zone_device *tz,
> > > > int
> > > > trip,
> > > > +                 bool *mode)
> > > > +{
> > > > +    struct __thermal_zone *data = tz->devdata;
> > > > +
> > > > +    if (trip >= data->ntrips || trip < 0)
> > > > +        return -EDOM;
> > > > +
> > > > +    *mode = data->trips[trip].irq_mode;
> > > > +
> > > > +    return 0;
> > > > +}
> > > > +
> > > >   static int of_thermal_get_trip_temp(struct
> > > > thermal_zone_device *tz,
> > > > int trip,
> > > >                       int *temp)
> > > >   {
> > > > @@ -394,6 +408,7 @@ static struct thermal_zone_device_ops
> > > > of_thermal_ops = {
> > > >       .set_mode = of_thermal_set_mode,
> > > >       .get_trip_type = of_thermal_get_trip_type,
> > > > +    .get_trip_irq_mode = of_thermal_get_trip_irq_mode,
> > > >       .get_trip_temp = of_thermal_get_trip_temp,
> > > >       .set_trip_temp = of_thermal_set_trip_temp,
> > > >       .get_trip_hyst = of_thermal_get_trip_hyst,
> > > > @@ -827,6 +842,8 @@ static int thermal_of_populate_trip(struct
> > > > device_node *np,
> > > >           return ret;
> > > >       }
> > > > +    trip->irq_mode = of_property_read_bool(np, "irq-mode");
> > > > +
> > > >       /* Required for cooling map matching */
> > > >       trip->np = np;
> > > >       of_node_get(np);
> > > > diff --git a/drivers/thermal/thermal_core.c
> > > > b/drivers/thermal/thermal_core.c
> > > > index 39fc812..6d41e08 100644
> > > > --- a/drivers/thermal/thermal_core.c
> > > > +++ b/drivers/thermal/thermal_core.c
> > > > @@ -406,6 +406,7 @@ static void handle_critical_trips(struct
> > > > thermal_zone_device *tz,
> > > >   static void handle_thermal_trip(struct thermal_zone_device
> > > > *tz, int
> > > > trip)
> > > >   {
> > > >       enum thermal_trip_type type;
> > > > +    bool irq_mode = false;
> > > >       /* Ignore disabled trip points */
> > > >       if (test_bit(trip, &tz->trips_disabled))
> > > > @@ -419,9 +420,14 @@ static void handle_thermal_trip(struct
> > > > thermal_zone_device *tz, int trip)
> > > >           handle_non_critical_trips(tz, trip);
> > > >       /*
> > > >        * Alright, we handled this trip successfully.
> > > > -     * So, start monitoring again.
> > > > +     * So, start monitoring in polling mode if
> > > > +     * trip is not using irq HW support.
> > > >        */
> > > > -    monitor_thermal_zone(tz);
> > > > +    if (tz->ops->get_trip_irq_mode)
> > > > +        tz->ops->get_trip_irq_mode(tz, trip, &irq_mode);
> > > > +
> > > > +    if (!irq_mode)
> > > > +        monitor_thermal_zone(tz);
> > > >   }
> > > handle_thermal_trip() is called from
> > > thermal_zone_device_update(), and
> > > it is invoked for every trip points.
> > > say, you have a passive trip point 1 that supports irq_mode, and
> > > another passive trip point 2 that does not support irq_mode,
> > > monitor_thermal_zone() is still called in handle_thermal_trip(tz,
> > > 2),
> > > and the passive timer will be activated anyway, do I miss
> > > something?

sorry that I missed this thread.

> > Yes, the passive timer will be activated in your example. It is
> > correct
> > behavior and does not break anything.
> > case 1: there is 'k' passive trip points which have irq_mode and 1
> > additional which does not have 'irq_mode', the framework will start
> > polling but skip check for those 'k' trip points.
> > case 2: all of the passive trip points have irq_mode set, the
> > framework
> > will not register 'scheduled_work' because it will not call 
> > 'monitor_thermal_zone()'.
> > This is the case of most Exynos platforms, but there is one
> > exception 
> > which has 'case 1' with 2 trip points not supporting irq_mode.
> Do you suggest to cover the 'case 1'?

So this solution does not cover case 1.
And for case 2, why not set passive_delay to 0? are they sharing the
same DT file?

> It would be possible after adding a new enum THERMAL_FRAMEWORK_POLL, 
> then function:

hmmm, I think we can
1. use tz->passive to count the passive trip points that need passive
polling.
2. count tz->passive properly in the governors
3. always do passive polling when tz->passive > 0.

This will cover both cases, right?

some sample code to handle this in step_wise governor attached below,

what do you think?

thanks,
rui

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index ee047ca..59d9a1d 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -121,8 +121,15 @@ static void update_passive_instance(struct
thermal_zone_device *tz,
         * If value is +1, activate a passive instance.
         * If value is -1, deactivate a passive instance.
         */
-       if (type == THERMAL_TRIP_PASSIVE || type == THERMAL_TRIPS_NONE)
-               tz->passive += value;
+       if (type != THERMAL_TRIP_PASSIVE && type != THERMAL_TRIPS_NONE)
+               return;
+       if (tz->ops->get_trip_irq_mode) {
+               if (tz->ops->get_trip_irq_mode(tz, trip, &irq_mode))
+                               return;
+               if (irq_mode)
+                               return;
+       }
+       tz->passive += value;
 }


> thermal_zone_device_check() will call
> thermal_zone_device_update(tz, THERMAL_FRAMEWORK_POLL)
> and in handle_thermal_trip() implement something like:
> --------------8<----------------
> static void handle_thermal_trip(struct thermal_zone_device *tz, int
> trip)
> {
> 	enum thermal_trip_type type;
> 	bool irq_mode = false;
> 
> 	/* Ignore disabled trip points */
> 	if (test_bit(trip, &tz->trips_disabled))
> 		return;
> 
> 	if (tz->ops->get_trip_irq_mode)
> 		tz->ops->get_trip_irq_mode(tz, trip, &irq_mode)
> 
> 	if (tz->notify_event == THERMAL_FRAMEWORK_POLL && irq_mode)
> 		return;
> ...
> 
> 	if (!irq_mode)
> 		monitor_thermal_zone(tz);
> }
> 
> ---------->8-----------------------
> 
> I could implement it in v3 if you don't see that it add too much of
> mess 
> and agree for this approach.
> 
> Regards,
> Lukasz
> 
> > 
> > 
> > Regards,
> > Lukasz
> > 
> > > 
> > > 
> > > thanks,
> > > rui
> > > 
> > > > 
> > > >   static void update_temperature(struct thermal_zone_device
> > > > *tz)
> > > > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > > > index 5f4705f..b064565 100644
> > > > --- a/include/linux/thermal.h
> > > > +++ b/include/linux/thermal.h
> > > > @@ -103,6 +103,7 @@ struct thermal_zone_device_ops {
> > > >           enum thermal_device_mode);
> > > >       int (*get_trip_type) (struct thermal_zone_device *, int,
> > > >           enum thermal_trip_type *);
> > > > +    int (*get_trip_irq_mode) (struct thermal_zone_device *,
> > > > int,
> > > > bool *);
> > > >       int (*get_trip_temp) (struct thermal_zone_device *, int,
> > > > int
> > > > *);
> > > >       int (*set_trip_temp) (struct thermal_zone_device *, int,
> > > > int);
> > > >       int (*get_trip_hyst) (struct thermal_zone_device *, int,
> > > > int
> > > > *);
> > > > @@ -196,6 +197,7 @@ struct thermal_zone_device {
> > > >       struct thermal_attr *trip_temp_attrs;
> > > >       struct thermal_attr *trip_type_attrs;
> > > >       struct thermal_attr *trip_hyst_attrs;
> > > > +    struct thermal_attr *trip_irq_mode_attrs;
> > > >       void *devdata;
> > > >       int trips;
> > > >       unsigned long trips_disabled;    /* bitmap for disabled
> > > > trips */
> > > > @@ -364,6 +366,8 @@ struct thermal_zone_of_device_ops {
> > > >    * @temperature: temperature value in miliCelsius
> > > >    * @hysteresis: relative hysteresis in miliCelsius
> > > >    * @type: trip point type
> > > > + * @irq_mode: to not use polling in framework set support of
> > > > HW irq
> > > > (which will
> > > > + *          be triggered when temperature reaches this level).
> > > >    */
> > > >   struct thermal_trip {
> > > > @@ -371,6 +375,7 @@ struct thermal_trip {
> > > >       int temperature;
> > > >       int hysteresis;
> > > >       enum thermal_trip_type type;
> > > > +    bool irq_mode;
> > > >   };
> > > >   /* Function declarations */
> > > 
