Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC7DC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D26320854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ra4GRLFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D26320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeIKOAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:00:17 -0400
Received: from mail-eopbgr720042.outbound.protection.outlook.com ([40.107.72.42]:41770
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726522AbeIKOAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvL5F+ShxVGi1Kabeqfml0iihQNHOJuL1NHskdU8S/Q=;
 b=ra4GRLFQgy1tz5r0jlHuVo0Ag+97+n04ck2OmdV9p9Dv8cX3MDgXv0Rs/O5Ab9sRPOkbTLKGirhjxCywhxUkh75I1l4lDzz9iDk8mKY1IKDPXYmGSXIMKYHtt0CVmJgHHawBFTF0Zu+n6V4msHTBNPcoX4qD1sg46q2SyEgHQII=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB4565.namprd07.prod.outlook.com (52.135.225.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Tue, 11 Sep 2018 09:01:14 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::1592:3509:da97:4964]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::1592:3509:da97:4964%4]) with mapi id 15.20.1122.019; Tue, 11 Sep 2018
 09:01:13 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: RE: [PATCH 02/31] usb: usbssp: Added some decoding functions.
Thread-Topic: [PATCH 02/31] usb: usbssp: Added some decoding functions.
Thread-Index: AQHUH4o2wQdXJVn0ykOBksNGn6z7ZaTqJmQAgADAuYCAACgpgIAAAtuA
Date:   Tue, 11 Sep 2018 09:01:13 +0000
Message-ID: <BYAPR07MB4709D6250C7CD0941E39272BDD040@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
 <1532023084-28083-3-git-send-email-pawell@cadence.com>
 <20180910181856.GB6019@kroah.com> <87in3c1t50.fsf@linux.intel.com>
 <20180911081227.GB8963@kroah.com>
In-Reply-To: <20180911081227.GB8963@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctM2Q1OGQyMjAtYjVhMS0xMWU4LTg3MjEtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDNkNThkMjIxLWI1YTEtMTFlOC04NzIxLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjUzMyIgdD0iMTMxODExMzAwODAwMDg2MjE2IiBoPSJsUGpHQVh0akhUbHdBVmRRVHJqa2s2M0pjdFU9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pawell@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4565;20:pC92ZJWKco7bfIBWdvBpox4/8HvAbwStqST/dy6hoIkOeXUPFXKMKHgzI8SYrpnAWiQaWN+C9f7MjWB0+PtU7V4hDcLgO8zZyFKSeLQsu/BZdp6kntMaHHZAmH+t14XiYA0MsyZZo13kL/XrAI4dvdmo7QCCMFUP7fDOEImGJ7R+aMnIuxtrKfSmC/7egdY15Dy0fU6wpNwIV4WUzLVuFc+xKIWwWT3H5KjUSrhqLMD0QtyyJY2gpk6qNLof0yQ9
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(366004)(39860400002)(36092001)(69224002)(199004)(189003)(54906003)(53936002)(55016002)(7696005)(186003)(6436002)(102836004)(9686003)(97736004)(76176011)(486006)(14444005)(14454004)(6506007)(8936002)(5660300001)(81166006)(81156014)(256004)(11346002)(446003)(476003)(68736007)(478600001)(6116002)(8676002)(4326008)(3846002)(25786009)(7736002)(74316002)(305945005)(86362001)(33656002)(5250100002)(2900100001)(93886005)(107886003)(6246003)(105586002)(99286004)(106356001)(2906002)(110136005)(229853002)(66066001)(316002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4565;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 93bce29b-f1c3-49ab-f1c4-08d617c52053
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4565;
x-ms-traffictypediagnostic: BYAPR07MB4565:
x-microsoft-antispam-prvs: <BYAPR07MB4565E7233EFF4A2E679752A8DD040@BYAPR07MB4565.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BYAPR07MB4565;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4565;
x-forefront-prvs: 0792DBEAD0
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: acwNrIay60w1Uf5cT9jluKiNspCFWLvzhk/uVw+7A01BJOLeha9WwCL9VSV7C+eCK/A+n9HjF2P/68Hfhh42Z2MBvnIx9f+GUuC1NgmrM298JBBrtce5TwZwrv7uZCqsj/C6oN8QJrmVFTJSkASPMfHSoXCQ6o9Vnu2s4rPPGM291cXM+yCo1laERZHkXqyBrAWaNbeQwGyx1dbsejeOxq13gQ2VcjYOEmdGlXNT0+126rgyEiM34MfsppGFKYworuQyMJzMd4NFkN7Zm3ebP9xiDD08Y6p5Dtf8ot7g/4e3CvkvWVIlZaODn4n6VazA8VWIUp0rrCOp85tz4k2IG8JSYUK1CRa5pbfL/E1O8sk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bce29b-f1c3-49ab-f1c4-08d617c52053
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2018 09:01:13.5997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4565
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI, All=20
=20
Please stop review of this series. It's a pity of your time.=20

Probably the design of USBSSP device controller will be significantly chang=
ed and simplified, so=20
I will have to create new driver.=20

The planed change include:=20
   - simplification and change registers map
   - removing command queue=20
   -  simplification  in input/output endpoint context
   - and other.


It was not my decision. Thanks for all  your comments.
I will take them into account in new driver.=20

Cheers,
Pawell




>On Tue, Sep 11, 2018 at 08:48:43AM +0300, Felipe Balbi wrote:
>>
>> Hi,
>>
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> > On Thu, Jul 19, 2018 at 06:57:35PM +0100, Pawel Laszczak wrote:
>> >> This patch add additional functions that converts some fields to stri=
ng.
>> >>
>> >> For example function usbssp_trb_comp_code_string take completion
>> >> code value and return string describing completion code.
>> >>
>> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> >> ---
>> >>  drivers/usb/usbssp/gadget.h | 580 ++++++++++++++++++++++++++++++++++=
++
>> >>  1 file changed, 580 insertions(+)
>> >>
>> >> diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.=
h
>> >> index 49e7271187cc..b5c17603af78 100644
>> >> --- a/drivers/usb/usbssp/gadget.h
>> >> +++ b/drivers/usb/usbssp/gadget.h
>> >> @@ -930,6 +930,73 @@ struct usbssp_transfer_event {
>> >>  #define COMP_UNDEFINED_ERROR			33
>> >>  #define COMP_INVALID_STREAM_ID_ERROR		34
>> >>
>> >> +static inline const char *usbssp_trb_comp_code_string(u8 status)
>> >
>> > <snip>
>> >
>> >
>> > You have _giant_ inline functions here, why?
>> >
>> > Please just put this all in a .c file and let the linker properly hand=
le
>> > things.  You do not want to duplicate all of these crazy strings all
>> > over the place where ever you call these functions.
>> >
>> > And I am guessing this is only for some sort of "debugging" mode?  If
>> > so, shouldn't there be a way to not even build this in?  Some systems
>> > are very space constrained...
>>
>> many of them seem to be a straight copy from xhci.
>
>Which doesn't mean it's a great model to copy :)
>
>Let's learn from our past mistakes, having had to try to slim down a
>kernel for a limited memory system is a chore that no one should have to
>manually hack up the source tree just to accomplish it.
>
>thanks,
>
>greg k-h
