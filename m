Return-Path: <anuragku@xilinx.com>
X-Google-Smtp-Source: AG47ELvE75a8iQQdV0MAZjwatv38shCQ5geagVYPcG2J+DLT5AC4bDqFTVXZcxgr2aJo9pVYlo+s
ARC-Seal: i=1; a=rsa-sha256; t=1521914034; cv=none;
        d=google.com; s=arc-20160816;
        b=nsqFaAuTl/9YJF9tWNRNnTnEd2ThaQeLFzF++vH4ANNOtxk7DjBs/DVu7UUheDDzwd
         j4GAp6Q0ERNoumhw9hU7R58vdkRKfigmqor2Bidx5j38P18tN2ZIyXmVHxXeSd30mm/f
         1OXsMPdhWjW8CIlZDw8s4mBSr2mggHl3LMVTJ4hrUHje4+unprQIE5HVPJYSTDtTfCn8
         FX/EicTpyQpY5nxhQ0Du7Ks2XZniusk/35CB2oerzBolAXW63rLI7hXp5QNVK4TsmmSV
         aXdqBPphuhl+kw8oMaXaH5NeMH+e0Xx1CpDyDyLZZ15Mp8dSBXNCUMBodMy+ufpZKGFJ
         p5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=FJqf1G+TE5Au2X9dHlAfiKLl8Dyb2vkPT2nGbkkEpOc=;
        b=YXDUq19nfi+Qct0TjXjgouPxOI+m/8WlPhbAGMHOewOUrdB2PGFUDh+XpnS5ZNmu3s
         BiIz+zUknfvUa2GhT0DlzpsBOrsphkIG15qo2HsCQ84Qj3k3ksKBeR1joNb+A3qCBWX9
         g3CqjWQgNaPMuWZh/sODUxF/sUqxDjTB+ngimr0PAUv9X8ThIoQsc6GrG8UFq2md34Rp
         lwAZ7fK1K/+zZ17gw6yip+9z2EQDoAfNewK4HXQcEhLyt4hIZJ3sBdFCJecKNtaAQJ9j
         Stu9mbXcxdS6CoNEBkwPlYyXgxj8TdoHmrjoiL+p4QVDw9NDV1/ATdtuk62Rq18TW/c6
         IXiw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=lNNW5XeT;
       spf=pass (google.com: domain of anuragku@xilinx.com designates 104.47.41.76 as permitted sender) smtp.mailfrom=anuragku@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=lNNW5XeT;
       spf=pass (google.com: domain of anuragku@xilinx.com designates 104.47.41.76 as permitted sender) smtp.mailfrom=anuragku@xilinx.com
From: Anurag Kumar Vulisha <anuragku@xilinx.com>
To: Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>, "Ajay Yugalkishore
 Pandey" <APANDEY@xilinx.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc3: gadget: Correct the logic for queuing sgs
Thread-Topic: [PATCH] usb: dwc3: gadget: Correct the logic for queuing sgs
Thread-Index: AQHTv07Hj2BDwUGZJ0CZRNZYK+38v6PXQBOAgAAsIoCABkl9AIAB+xVg
Date: Sat, 24 Mar 2018 17:53:50 +0000
Message-ID: <MWHPR02MB281608B4FB50414005A5CEEAA7AF0@MWHPR02MB2816.namprd02.prod.outlook.com>
References: <1521442253-15906-1-git-send-email-anuragku@xilinx.com>
 <87fu4wqwis.fsf@linux.intel.com>
 <MWHPR02MB2816D32AE891F329232DA730A7D40@MWHPR02MB2816.namprd02.prod.outlook.com>
 <87lgejni7v.fsf@linux.intel.com>
In-Reply-To: <87lgejni7v.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com;
x-originating-ip: [182.18.177.170]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB3230;7:76Yq9kkKmCebdCDg7Jjyhlha2mo6Sa6R0P8CY7gsXIqCy3JxKH8tE1yYt95vMmw/nl0xKM4XAOZvIz8jSJ3JWw21Uqzrc7IFC9kcEkXrPpoEABsQA1/2DPHDfmrUB4n3dMtKcdR/pO7+cIaAwynOZKWbhQV6tGoQOz9EaV3Na3XJ6hne0P8xVuFImCcyz/hIuBeFM+2UgR+hbfxr1Q1E2HopNraMKBjD1L6pT8hLlKE0N4TSNR2N62EQFw4EM5RF
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2f554dd-801f-4a1f-f2a5-08d591b033cc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB3230;
x-ms-traffictypediagnostic: MWHPR02MB3230:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <MWHPR02MB3230F5F933A51A985F5E45D7A7AF0@MWHPR02MB3230.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(192813158149592);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR02MB3230;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3230;
x-forefront-prvs: 0621E7E436
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(396003)(39380400002)(376002)(189003)(199004)(13464003)(66066001)(110136005)(55016002)(54906003)(105586002)(68736007)(229853002)(6436002)(186003)(81166006)(11346002)(316002)(3660700001)(9686003)(102836004)(93886005)(33656002)(6116002)(26005)(6246003)(4326008)(97736004)(3280700002)(99286004)(446003)(59450400001)(53936002)(106356001)(8936002)(7736002)(39060400002)(7696005)(86362001)(74316002)(76176011)(305945005)(25786009)(5250100002)(81156014)(8676002)(478600001)(6506007)(14454004)(2900100001)(5660300001)(3846002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3230;H:MWHPR02MB2816.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 3uh8INDgAKTXhvMCwA7LGUr/JqYZXlaaBMmPXSuHRH5ZgE5e3XTBY+EsraboIB0u/ZTFN1EProkyYf56/1F7yO9FHXhLdHjxSmmFoybdq6SQLgxUvtPZzcuIYMcHeyfkzkgWuOAzVTnwf7CHr3KUYiOnt3ho05FcQNIS/UV9k0S0IHNec4TvISSZq1oQoJJ8lqEoX/BDHz7W3xtpubE2Y6UopfQ0ssnByBNwpGZl0rf1np3ovChcf3LTxrfLgPs6jSUHgJFevEwZspyt4takkbnYVwV17ZbvGqL7F1dBIXf3aOdgFH1Pdg11ofRRQWi/C0wyEQjB1y96S6S0BzvoNg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f554dd-801f-4a1f-f2a5-08d591b033cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2018 17:53:51.0162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3230
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595347861307192100?=
X-GMAIL-MSGID: =?utf-8?q?1595842529473458747?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Felipe,

Thanks for providing your inputs on this patch. Will send v2 with all your
suggestions added.

Thanks,
Anurag Kumar Vulisha

>-----Original Message-----
>From: Felipe Balbi [mailto:balbi@kernel.org]
>Sent: Friday, March 23, 2018 4:59 PM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>
>Cc: v.anuragkumar@gmail.com; Ajay Yugalkishore Pandey
><APANDEY@xilinx.com>; linux-usb@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Subject: RE: [PATCH] usb: dwc3: gadget: Correct the logic for queuing sgs
>
>
>(please configure your email client to break lines at 80 columns ;-)
>
>Hi,
>
>Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
>> Hi Felipe,
>>
>> Thanks for reviewing the patch , please find my comments inline
>
>no issues :-)
>
>>>Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com> writes:
>>>> This patch fixes two issues
>>>>
>>>> 1. The code logic in dwc3_prepare_one_trb() incorrectly uses the
>>>> address and length given in req packet even for scattergather lists.
>>>> This patch correct's the code to use sg->address and sg->length when
>>>> scattergather lists are present.
>>>>
>>>> 2. The present code correctly fetches the req's which were not
>>>> queued from the started_list but fails to start from the sg where it
>>>> previously stopped queuing because of the unavailable TRB's. This
>>>> patch correct's the code to start queuing from the correct sg in sglis=
t.
>>>
>>>these two should be in separate patches, then.
>>>
>> Will create separate patches in next version
>
>thanks, that helps :-)
>
>>>> Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
>>>> ---
>>>>  drivers/usb/dwc3/core.h   |  4 ++++
>>>>  drivers/usb/dwc3/gadget.c | 42
>>>> ++++++++++++++++++++++++++++++++++++------
>>>>  2 files changed, 40 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h index
>>>> 860d2bc..2779e58 100644
>>>> --- a/drivers/usb/dwc3/core.h
>>>> +++ b/drivers/usb/dwc3/core.h
>>>> @@ -718,7 +718,9 @@ struct dwc3_hwparams {
>>>>   * @list: a list_head used for request queueing
>>>>   * @dep: struct dwc3_ep owning this request
>>>>   * @sg: pointer to first incomplete sg
>>>> + * @sg_to_start: pointer to the sg which should be queued next
>>>>   * @num_pending_sgs: counter to pending sgs
>>>> + * @num_queued_sgs: counter to the number of sgs which already got
>>>> + queued
>>>
>>>this is the same as num_pending_sgs.
>>
>> num_pending_sgs is initially pointing to num_mapped_sgs, which gets
>> decremented in dwc3_cleanup_done_reqs().
>>
>> Consider a case where the driver failed to queue all sgs into TRBs
>> because of insufficient TRB number. For example, lets assume req has 5
>> sgs and only 3 got queued. In this scenario ,when the
>> dwc3_cleanup_done_reqs() gets called the value of num_pending_sgs =3D 5.
>> Since the value of num_pending_sgs is greater than 0,
>> __dwc3_gadget_kick_transfer() gets called with num_pending_sgs =3D 5-1 =
=3D
>> 4.
>>
>> Eventually __dwc3_gadget_kick_transfer() calls
>> dwc3_prepare_one_trb_sg() which has for_each_sg() call which loops for
>> num_pending_sgs times (4 times in our example). This is incorrect,
>> ideally it should be called only for 2 times because we have only 2
>> sgs which previously were not queued.
>>
>> So, we added an extra flag num_queued_sgs which counts the number of
>> sgs that got queued successfully and make for_each_sg() loop for
>> num_mapped_sgs - num_queued_sgs times only . In our example case with
>> the updated logic, it will loop for 5 - 3 =3D 2 times only. Because of
>> this reason added num_queued_sgs flag. Please correct me if I am
>> wrong.
>
>That's true. Seems like we do need a new counter.
>
>>>> static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep
>>>> *dep,
>>>>
>>>>                 req->request.actual =3D length - req->remaining;
>>>>
>>>> -               if ((req->request.actual < length) && req->num_pending=
_sgs)
>>>> -                       return __dwc3_gadget_kick_transfer(dep);
>>>> +               if (req->request.actual < length ||
>>>> + req->num_pending_sgs) {
>>>
>>>why do you think this needs to be || instead of &&? If actual =3D=3D
>>>length we're done, there's nothing more left to do. If there is either
>>>host sent more data than it should, or we miscalculated
>>>num_pending_sgs, or we had the wrong length somewhere in some TRBs.
>>>Either of those cases is an error condition we don't want to hide. We wa=
nt
>things to fail in that case.
>>>
>>
>> Consider the same example that we had previously discussed, among the
>> 5 sgs only 3 sgs got queued and all 3 sgs got completed successfully.
>> The req->remaining field represents the size of TRB which was not
>> transferred. In this example , as 3 sgs got completed successfully the
>> req-> remaining =3D 0. So , request.actual =3D length - 0
>> (req->remaining) which means request.actual =3D=3D length.  Because of
>> this , the condition check if ((req->request.actual < length) &&
>> req->num_pending_sgs) ) fails even though we have req->num_pending_sgs
>> > 0.  So, corrected the logic to always kick transfer for two
>> conditions 1) if req->num_pending_sgs > 0 2) if ((req->request.actual
>> < length) && req->num_pending_sgs)) condition satisfies. Please
>> correct me If my understanding is wrong.
>
>fair enough, but then we miss an important (IMO, that is) error case. If
>req->num_pending_sgs > 0 && actual =3D=3D length, then something is super
>wrong. We may just add it as an extra check:
>
>	dev_WARN_ONCE(.... actual =3D=3D len && num_pending_sgs);
>
>--
>balbi
