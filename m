Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36919C65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9A92082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544432600;
	bh=VrAcmO4bkB61hNa50s9nuJmWPSypu3CIqGmrIbe0f6I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=PwlLdmkOlwCKHNwMzks2PMFNQNTB82flchl2z0aC4L7dzXtwAkBIc/0XOBZrkPUKp
	 uxsiiIBWgj2/8aZdlwDT2KNFYUj6XNye7E6d0KkidIr8mVBYc3beMZ6FPizcXvHPmj
	 6t/G26kJJ9bKKkyUD9eEfmcslnjw/BXnclBXHZGY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9A92082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeLJJDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:03:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:32865 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbeLJJDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:03:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 01:03:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,337,1539673200"; 
   d="asc'?scan'208";a="258218949"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga004.jf.intel.com with ESMTP; 10 Dec 2018 01:03:11 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        "martin.petersen\@oracle.com" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>
Cc:     "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar\@gmail.com" <v.anuragkumar@gmail.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>
Subject: RE: [PATCH v7 09/10] usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl fields
In-Reply-To: <BL0PR02MB56338A2EA4515527AA0EECF5A7A50@BL0PR02MB5633.namprd02.prod.outlook.com>
References: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com> <1543662811-5194-10-git-send-email-anurag.kumar.vulisha@xilinx.com> <875zw82vfj.fsf@linux.intel.com> <BL0PR02MB563352F83A80E3B92347A7A4A7A80@BL0PR02MB5633.namprd02.prod.outlook.com> <874lbpx3vg.fsf@linux.intel.com> <BL0PR02MB56331B2ECFFEB96A99936C32A7AB0@BL0PR02MB5633.namprd02.prod.outlook.com> <87pnu927oq.fsf@linux.intel.com> <BL0PR02MB56338A2EA4515527AA0EECF5A7A50@BL0PR02MB5633.namprd02.prod.outlook.com>
Date:   Mon, 10 Dec 2018 11:03:07 +0200
Message-ID: <87efap21pw.fsf@linux.intel.com>
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

Anurag Kumar Vulisha <anuragku@xilinx.com> writes:
>>>>> Thanks for reviewing this patch. Lets consider an example where a
>>>>> request has num_sgs > 0 and each sg is mapped to a TRB and the last
>>>>> TRB has the IOC bit set. Once the controller is done with the
>>>>> transfer, it  generates XferInProgress for the last TRB (since IOC bit
>>>>> is set). As a part of trb reclaim process
>>>>> dwc3_gadget_ep_reclaim_trb_sg() calls
>>>>> dwc3_gadget_ep_reclaim_completed_trb() for req->num_sgs times. Since
>>>>> the event already has the IOC bit set, the loop is exited from the
>>>>> loop at the very first TRB and the remaining TRBs (mapped to the sgli=
st) are left
>>>>unhandled.
>>>>> To avoid this we modified the code to exit only if both TRB & event
>>>>> has the IOC bit set.
>>>>
>>>>Seems like IOC case should just test for chain flag as well:
>>>>
>>>
>>> Okay. Along with this logic the code for updating chain bit should also=
 be modified I
>>guess.
>>
>>not really
>>
>>> Since the IOC bit is also set when there are not enough TRBs available,=
 the code
>>should be
>>> modified to not set DWC3_TRB_CTRL_CHN bit when the IOC bit is set. I wi=
ll update
>>below
>>> changes along with your suggestions and resend the patches.
>>
>>no. Actually I don't think we're allowed to split a scatter/gather like
>>that. I did that quite a while ago, but I don't think we're allowed to
>>do so. What we should do, in that case, is not even queue that request
>>until we have enough for all members of the scatter/gather. But that's a
>>separate patch, anyway.
>>
>
> Okay. I have a doubt here, not pushing the request until all sgs are mapp=
ed to enough TRBs
> might remove the driver complexity but reduce the performance (since we a=
re waiting
> until enough TRBs are available). Are we okay with that?=20=20

The only other way would be to copy the buffer over to a contiguous
buffer. That will also reduce performance. I think we need to consider
how frequently this may actually happen. I dare to say we don't have any
usb function in kernel as of today that can, easily and frequently, fall
into such a situation. Besides, the performance loss can be amortized by
a deeper request queue.

IMO, this is a minor problem. But, certainly, if you have the setup,
_do_ run some benchmarking and report your findings :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlwOK8sACgkQzL64meEa
mQaXhA//bnb/3Wsz/IBeBQWc3LG+ucRpdOc0SXEXvKyxFDyCDpHZx5jmFXP7IubP
4vjBeiLmOjK+Nduqe6dcot/tfjM7UDgXdvtVKHXnfMTUiH2lzB2spl/8E4Yt6PM6
MMV3nBip4jcu/stg6Y2eQf4k22zZyMJZ4W1qA/ibueQn0sDsNH6y7R004Eaesiqw
StteapMe8Ke6o63db/5wviU4UAditIDSkOcPwTkuXXKoQX84g4jUxUPFQqDXXGWX
SDfl7uX4YVhdloKxgMinogN9qBHNqc+Z3ZAKwtM/Z97vdqz9YOx21EGTqlbMwV2B
MwG+rT4Rtrt4Ay77QfHojV+qxF5Lq8As8/7jloFRl365sIoUnoDhhPezHPPM1OPi
h0bAxwlgOF8sGKQT8o6BfwV6mNnj7EvPVx02mwlRH+8ZW6ASUFcRw8VZ8VDSsQi3
0RuzP5TsXLKe5fOR2PVvTRgtkjOIwajUr4PhZMves9tSdFc4MVQVrFftRu7A7w5K
Kmg/t5V99ZvCQWX9rGJ252flo2n6ZX+roPNtk8z4Iw3/3HvWs+ON7osnoE8EoTnO
kUl5GROJ5UAFZPgcCuTv+KnZX5A71P7VLp7VY1EKL+k6jlWO9V/iMbS/CuRWZ79P
OC0aAHz8wlR40dWf6ILeaCg/AY1UW1Xvv/NGEfqrZfguPf2RDZE=
=d0zW
-----END PGP SIGNATURE-----
--=-=-=--
