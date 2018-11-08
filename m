Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7EBECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227CC20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="ZsJw3tm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227CC20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeKIDhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:37:42 -0500
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:29581 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726672AbeKIDhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1541700063; x=1573236063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=80bhJHupQ2IUkLOmzxzXEY38qfz1drjWEZhw6+jeCIk=;
  b=ZsJw3tm/jLLcX9zd44TsyG8gy/7Fw9b4CBl7ubrYOYz7y0Ytkw0+/909
   Efl41AVO5urSN6HVA+Nemrybgfghty4EUYE+5zXETmCgs0po33azKUiOj
   uJ2badLNTgel83+1A7qDOMWIpGOw822F2w10PF8RPILKPpWMQ/xCm6k8D
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EYAAAkeeRbhyeV50NdBw4OAQEBBAE?=
 =?us-ascii?q?BBwQBAYFSBgEBCwGBVYIWJwqMZY0plzIUgWYLAQGEbAKDOzUMDQEDAQECAQE?=
 =?us-ascii?q?CAQECEAEBAQoLCQgpL4I2IoJjAQEBAQIBEig0CwULAgEIGB4QVwIEDgUIGoJ?=
 =?us-ascii?q?/gXoInQoCgRCJWAEBAYIciiqOEIERgxKEPSUFBAiFZgKJJRaLXYowBwKRDiC?=
 =?us-ascii?q?QbIdDkAYCBAIEBQIUgUQBggxwUIJsgicOCY1iOkABMYsEKYEFgR8BAQ?=
X-IPAS-Result: =?us-ascii?q?A2EYAAAkeeRbhyeV50NdBw4OAQEBBAEBBwQBAYFSBgEBC?=
 =?us-ascii?q?wGBVYIWJwqMZY0plzIUgWYLAQGEbAKDOzUMDQEDAQECAQECAQECEAEBAQoLC?=
 =?us-ascii?q?QgpL4I2IoJjAQEBAQIBEig0CwULAgEIGB4QVwIEDgUIGoJ/gXoInQoCgRCJW?=
 =?us-ascii?q?AEBAYIciiqOEIERgxKEPSUFBAiFZgKJJRaLXYowBwKRDiCQbIdDkAYCBAIEB?=
 =?us-ascii?q?QIUgUQBggxwUIJsgicOCY1iOkABMYsEKYEFgR8BAQ?=
Received: from mx0a-00154901.pphosted.com (HELO mx0b-00154901.pphosted.com) ([67.231.149.39])
  by esa6.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Nov 2018 12:01:02 -0600
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8HwRhh111507
        for <linux-kernel@vger.kernel.org>; Thu, 8 Nov 2018 13:01:02 -0500
Received: from esa3.dell-outbound2.iphmx.com (esa3.dell-outbound2.iphmx.com [68.232.154.63])
        by mx0b-00154901.pphosted.com with ESMTP id 2nmksft9pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 13:01:01 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausxippc110.us.dell.com ([143.166.85.200])
  by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Nov 2018 00:00:52 +0600
X-LoopCount0: from 10.166.132.152
X-IronPort-AV: E=Sophos;i="5.54,480,1534827600"; 
   d="scan'208";a="726930160"
To:     <tytso@mit.edu>
CC:     <mika.westerberg@linux.intel.com>, <whitequark@whitequark.org>,
        <heikki.krogerus@linux.intel.com>, <linux-kernel@vger.kernel.org>
Subject: RE: A different PD controller firmware problem?
Thread-Topic: A different PD controller firmware problem?
Thread-Index: AQHUXToJF81sFBZaW0a4ysAxNw+sQKVGWhIQ
Date:   Thu, 8 Nov 2018 18:00:59 +0000
Message-ID: <d92aef18a8ac4ef5ab3fcafaaf03afec@ausx13mpc120.AMER.DELL.COM>
References: <1e8398f2c1790890f40b69f12e2934e3@whitequark.org>
 <20180903140623.GD15112@kuha.fi.intel.com>
 <28522bb57c5d8f49416b9174b19b1625@whitequark.org>
 <20180905132429.GB25121@kuha.fi.intel.com>
 <4df3faaee8904d81bf7737b5f2daaff5@ausx13mpc120.AMER.DELL.COM>
 <a2f79cc4d9a0aab4a832de31b7ddc52d@whitequark.org>
 <3a666f66d6e342e2971b800caae7c889@whitequark.org>
 <3b76178ca0de4990a38362cfd4836fdc@ausx13mpc120.AMER.DELL.COM>
 <20180911093239.GW14465@lahna.fi.intel.com>
 <fd00612c1bb94f69820be2b1f1e171f9@ausx13mpc120.AMER.DELL.COM>
 <20181006060121.GA4050@thunk.org>
In-Reply-To: <20181006060121.GA4050@thunk.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ted,

Sorry for my delayed responses.

>=20
> On Tue, Sep 11, 2018 at 01:02:00PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > > I tried 9370 and it detects the adapter correctly. IIRC I did the sam=
e
> > > for 5530 and it worked as well.
> >
> > Thanks for confirming that.  Hopefully the same change can be ported to=
 PD
> controller
> > firmware then on other models, I'll inquire.
>=20
> Hey Mario,
>=20
> Sorry for the thread hijack (I've changed the subject line to make it
> clear it's a separate issue), but just this evening I just had a
> very.... interesting problem with my Dell XPS 9370, and it appears to
> be related to the PD controller.
>=20
> Sortly after 12:30am US/Eastern, I got a low power warning on my
> system, and the battery power had dropped below 10%.  Apparently the
> laptop was not accepting any charge any more.  I tried doing a suspend
> to ram, and then unsuspended it, and it still wasn't accepting any
> charge, even though the adapter indicated it was plugged in and
> supplying power.  I then did a power cycle, and still the laptop
> didn't indicate it was charging with a USB C 45W power supply plugged
> in.

Just to be clear was this a Dell adapter or another manufacturer?

If it's non-Dell, there could easily be an untested combination of controll=
ers
and one getting into a bad state.

>=20
> I inserted a Satechi USB C voltage monitor in-line, and found that
> while it was powered on, the laptop has pulling 0 mA at 5V.  If the
> laptop was suspended, it would pull 3A at 5V.  Rebooting and power
> cycling didn't change this syndrome.
>=20
> What *did* fix it was powering down, and disconnecting the power
> adapter for 30 seconds or so.  Then when I plugged it back in, the
> laptop started accepting 20V at 2A.  I assume what happened is that
> the PD controller had crashed, and it required a powerdown *and*
> unplugging the power to force the EC to reset.

That's the same hypothesis I would have come to in these circumstances.

I haven't heard of this particular issue in the past, but that doesn't mean
anything since I don't work in Dell's support group or have access to their
call information.

Is this a 1 time occurrence or something you can regularly trigger with the
right set of events?

As you know if you can't trigger it regularly it's going to be just as hard
for this to be reproduced and fixed by the engineering team maintaining
this platform.

If you can trigger it regularly (or semi-regularly even) the right way to r=
eport
it would be to contact the ProSupport team, explain the circumstances that
can cause it and they would escalate it to the proper channels.

Sorry I can't be more helpful.

>=20
> I have noticed other problems where a USB C to HDMI adapter doesn't
> quite work right (the laptop refuses to talk to the display), and the
> *only* way to fix things is to powerdown Linux and then remove the
> power plug. =20

Is this with the DA200 or DA300?  Or something else?

I think it would be worth checking this with drm-tip, and if it keeps repro=
ducing
there then:
1) Check if UCSI sysfs can tell you anything about what accessory mode the =
device is operating in.
I'm not sure if accessory_mode gets populated by the EC, but if it does it =
might be useful to debug.

2) Boot with drm.debug=3D0xe and double check the differences around the ci=
rcumstances
of it working or not working.  Having to boot with it plugged in for it to =
work tells
me that it's either the wrong type C alternate mode coming up for this adap=
ter or the graphics
driver not getting along with the adapter.

3) Raising it with the graphics mailing list.

> So this is not the first time that this particular
> technique is needed to make my Dell XPS 9370 (with NVMe SSD, currently
> running XPS 13 9370 System Firmware version 0.1.5.1) happy again.
>=20
> What's the best place to report this sort of problem?  And is there
> anything more I can do to debug these sorts of apparent PD Controller
> / EC bugs?

It sounds like this one might be more reproducible.  If it's a Dell periphe=
ral I think it should be
pretty easy for support to reproduce and escalate.

