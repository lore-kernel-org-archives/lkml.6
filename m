Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230D8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCAA20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547198478;
	bh=fVNOIb5a4GeBaDXRTWB/ohknU5FrRErhCpuT8IJxtCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=PKZK9r5DPgSB5vT44xWKq/+OT/koKt/RylsmVKR8uavU8JiQlBIoPLB42zf5hXFtz
	 iaFnW1V4HEZM6lmNFwANs2ehtxwGrdLLcTd9CMdXN89P1jhnnDrV+NE24ZMaxKkOvF
	 eulQdUEZ20/IN60j4eSWHIekRkiNZWtey9eU8X0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbfAKJVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:21:17 -0500
Received: from mga07.intel.com ([134.134.136.100]:25562 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbfAKJVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:21:16 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2019 01:21:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,465,1539673200"; 
   d="asc'?scan'208";a="115965735"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jan 2019 01:21:13 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Manu Gautam <mgautam@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list\:DESIGNWARE USB3 DRD IP DRIVER" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Fail request submission if it was already queued
In-Reply-To: <d0f73188-7943-146f-5944-1bfd74bdce77@codeaurora.org>
References: <20190111060212.7390-1-mgautam@codeaurora.org> <87pnt3od02.fsf@linux.intel.com> <d0f73188-7943-146f-5944-1bfd74bdce77@codeaurora.org>
Date:   Fri, 11 Jan 2019 11:21:09 +0200
Message-ID: <87k1jbo8hm.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Manu Gautam <mgautam@codeaurora.org> writes:
>> Manu Gautam <mgautam@codeaurora.org> writes:
>>> If a function driver tries to re-submit an already queued request,
>>> it can results in corruption of pending/started request lists.
>>> Catch such conditions and fail the request submission to DCD.
>>>
>>> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
>>> ---
>>>  drivers/usb/dwc3/gadget.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>> index 679c12e14522..51716c6b286a 100644
>>> --- a/drivers/usb/dwc3/gadget.c
>>> +++ b/drivers/usb/dwc3/gadget.c
>>> @@ -1290,6 +1290,12 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep=
 *dep, struct dwc3_request *req)
>>>  				&req->request, req->dep->name))
>>>  		return -EINVAL;
>>>=20=20
>>> +	if (req->request.status =3D=3D -EINPROGRESS) {
>> this test is really not enough. What if gadget driver set status to
>> EINPROGRESS before submission? A better check would involve making sure
>> req isn't part of dep->pending_list or dep->started_list or
>> dep->cancelled_list. It's clear that this won't work very well as the
>> amount of requests grow.
>
> Thanks for quick review.
> 'request.status' check can be replaced:
> +if (!list_empty(&req->list) {
>
> And replace list_del with list_del_init from dwc3_gadget_giveback()

I would rather avoid this. We could start tracking our own internal
dwc3_request status. Something along the lines of:

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index df876418cb78..5c3ee741541f 100644
=2D-- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -863,6 +863,7 @@ struct dwc3_hwparams {
  * @num_pending_sgs: counter to pending sgs
  * @num_queued_sgs: counter to the number of sgs which already got queued
  * @remaining: amount of data remaining
+ * @status: internal dwc3 request status tracking
  * @epnum: endpoint number to which this request refers
  * @trb: pointer to struct dwc3_trb
  * @trb_dma: DMA address of @trb
@@ -883,6 +884,14 @@ struct dwc3_request {
 	unsigned		num_pending_sgs;
 	unsigned int		num_queued_sgs;
 	unsigned		remaining;
+
+	unsigned int		status;
+#define DWC3_REQUEST_STATUS_QUEUED	0
+#define DWC3_REQUEST_STATUS_STARTED	1
+#define DWC3_REQUEST_STATUS_CANCELLED	2
+#define DWC3_REQUEST_STATUS_COMPLETED	3
+#define DWC3_REQUEST_STATUS_UNKNOWN	-1
+
 	u8			epnum;
 	struct dwc3_trb		*trb;
 	dma_addr_t		trb_dma;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 07bd31bb2f8a..74db274786bc 100644
=2D-- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -208,6 +208,7 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct d=
wc3_request *req,
 	struct dwc3			*dwc =3D dep->dwc;
=20
 	dwc3_gadget_del_and_unmap_request(dep, req, status);
+	req->status =3D DWC3_REQUEST_STATUS_COMPLETED;
=20
 	spin_unlock(&dwc->lock);
 	usb_gadget_giveback_request(&dep->endpoint, &req->request);
@@ -846,6 +847,7 @@ static struct usb_request *dwc3_gadget_ep_alloc_request=
(struct usb_ep *ep,
 	req->direction	=3D dep->direction;
 	req->epnum	=3D dep->number;
 	req->dep	=3D dep;
+	req->status	=3D DWC3_REQUEST_STATUS_UNKNOWN;
=20
 	trace_dwc3_alloc_request(req);
=20
@@ -1434,6 +1436,11 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *de=
p, struct dwc3_request *req)
 				&req->request, req->dep->name))
 		return -EINVAL;
=20
+	if (WARN(req->status < DWC3_REQUEST_STATUS_COMPLETED,
+				"%s: request %pK already in flight\n",
+				dep->name, &req->request))
+		return -EINVAL;
+
 	pm_runtime_get(dwc->dev);
=20
 	req->request.actual	=3D 0;
@@ -1442,6 +1449,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep=
, struct dwc3_request *req)
 	trace_dwc3_ep_queue(req);
=20
 	list_add_tail(&req->list, &dep->pending_list);
+	req->status =3D DWC3_REQUEST_STATUS_QUEUED;
=20
 	/*
 	 * NOTICE: Isochronous endpoints should NEVER be prestarted. We must
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 023a473648eb..6aebe8c0eae1 100644
=2D-- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -76,6 +76,7 @@ static inline void dwc3_gadget_move_started_request(struc=
t dwc3_request *req)
 	struct dwc3_ep		*dep =3D req->dep;
=20
 	req->started =3D true;
+	req->status =3D DWC3_REQUEST_STATUS_STARTED;
 	list_move_tail(&req->list, &dep->started_list);
 }
=20
@@ -91,6 +92,7 @@ static inline void dwc3_gadget_move_cancelled_request(str=
uct dwc3_request *req)
 	struct dwc3_ep		*dep =3D req->dep;
=20
 	req->started =3D false;
+	req->status =3D DWC3_REQUEST_STATUS_CANCELLED;
 	list_move_tail(&req->list, &dep->cancelled_list);
 }
=20
With this, we can remove some of the other request flags, such as "started".

>> Anyway, which gadget driver did this? Why is it only affecting dwc3?
>
> Function driver is not in upstream (f_mtp.c).

So this could happen with any UDC, right? Why is f_mtp.c queueing the
same request twice?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlw4YAUACgkQzL64meEa
mQZOcg/+NfHKxPdOWjps2XB/tM0mdLAdmFQbnf9SSgiozoqV9GXiZTGmpUcNufoN
Q9/fc7Aiad9pN63mMEzfyF+YWEIF/e37LZhhH0TaQl+VVDeAbMli+FoGOKv6Py1W
x9sZX7yMrG2fqUiwRFiZ0XIBLxjFD5vIZiC6DYF/KaLUxIT6V+UXc8Z6Z3fP06ov
ABmMvG2EHU+vXshFRVg3ROogu+/ZGxz3URHtvyf0xRghjICFz9gvXHM4+4k67742
uNR3Yi00qZ5rMGjORFySoD3kctTid6vnhXMwMs7ro4KuOALazvmqs3lKDGG3Prt/
/XEj76PvP/PNTPlLGjfZ2pfEuBs1Pi99UP9Ec2w4plepZjWapkZsEkx4DwjE6tpl
VKKLCeeeAJVSWpKsSNgQPP/dRYduF5+LYlHXqrsViALgSTvB1/6RKod5qGwBRb9+
vWCjZlAEnPpiTJUzpevv4rBGIlMTNhYN9GefB+xjn7adildR+wPZvMn7j1RsGRqr
btfqrAYcZPtouhSWZZRqWYNV8B7sz/taim36/vMNkoMMDNz63kQOuNDXA5JHjKKJ
7fXkY+6fiA0eH8hj3RXaNKrIL7OgDuOhLDpBjbJR6hB613KtsLHbpgW1ZGyyAxwI
TTp6x/S9ganAXZnjq04cdSlP5Fq51hjVz2r4pIJycawwic4isK4=
=v5Qv
-----END PGP SIGNATURE-----
--=-=-=--
