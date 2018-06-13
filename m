Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 426AEC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF18208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="U+o7Br7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF18208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934981AbeFMJQD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:16:03 -0400
Received: from mail-eopbgr720086.outbound.protection.outlook.com ([40.107.72.86]:4874
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934073AbeFMJQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8N66yBvrv/3CrWhulqbH89kgTVXCyS2l3bAXfjg0f0=;
 b=U+o7Br7lC/vdzJ/gkxLXq8SpVZ6UDVTIUs2SH1rrK3eLg7jbsH9yMu0sJhHq+rbuh2YIPlqcSq+gLCIQfktfBhB6bCx1TISsuY2fzvlyUIAcwsbk6uVX58zWqo0lmJsXSI8iocRK9FiOZizEOB23tSf+T8/0URJbbWXy2gegA/c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com; 
Received: from localhost.localdomain (50.233.148.156) by
 MWHPR07MB3008.namprd07.prod.outlook.com (2603:10b6:300:e0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Wed, 13 Jun 2018 09:15:59 +0000
Date:   Wed, 13 Jun 2018 02:15:39 -0700
From:   Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To:     David Miller <davem@davemloft.net>
Cc:     dnelson@redhat.com, rric@kernel.org, sgoutham@cavium.com,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vadim.Lomovtsev@cavium.com
Subject: Re: [PATCH] net: thunderx: prevent concurrent data re-writing by
 nicvf_set_rx_mode
Message-ID: <20180613091539.GA21252@localhost.localdomain>
References: <20180608092759.28059-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180610.123551.885190586229525170.davem@davemloft.net>
 <036618ae-887f-44b5-2b39-451b81191cc1@redhat.com>
 <20180612.152540.1304714747425091865.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612.152540.1304714747425091865.davem@davemloft.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BYAPR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:a03:40::48) To MWHPR07MB3008.namprd07.prod.outlook.com
 (2603:10b6:300:e0::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e70daf6b-90cc-473b-3948-08d5d10e4724
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB3008;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3008;3:5sqJqjZnxyC377wj6KGAB0W0YDrhtOcdx1yqu4NSAOeZv81oGpcGiy508Zm10UvelZPD9YWpRgnJ+LsnmXZx3yhWY37jaezbJZSFqq2+YWvsa0Yljki01yOgO2WvSCnwgwtOY92NAZRmTBZIV4DrdHe+6vypIbHWZ8PybQ+Fc+ZTYk4AcL48GE2UFtD6h0cEKNPnbLWtakBuxpbEYqBHsKRTUG4hJl9pAnwDcHoARDTX0Ax+VKvsmbekvlzLMQC7;25:iPdzORxiCEULJJForRu+4wOnH3qu2L84Y10ejHsXURFwhrTMM40c+0QweSYdlzRpFIZnoG0ej35HV7meSnneJTQh2Kxqgft1TpRVZ0Vp/To3+TPEJoZUOhveKvSUDlj40lgIj8hDUP8Gdctk3OJm6xgIa0fkH3WnFc81IBqewPGoETgP2DWh/i/owCqQ4r9CXSPKG0CWzzIgNL/76z/EYzBb1ylvMcdb4Hbp9l0IkvzBGoD+E1PSgQbdc5R/EOhhiOAPRplZQhGp1Ol5fMTfEFuQkUMpzikYdovjkzVbKBKm0EoADerwV5eQXzrXd6/RFLiSZVcWuNjHZFlpvR9y7Q==;31:9ybWsdMZZ9kNa/X1Mm7L0//Qghrd6DbRiEdCZd2ahaP11vG9tZ7bkrPgoZ3MkDIEWRoVg/hZxuyAAWNeqcYff1brk2Eq7Kd/nwMvRVMUIrzWL3acHbqX5dAqNFoqece+q0ouh0vONcMgUr9SmwapQfEWlPzgCOV263YwXh1FkzjxLP40onh1du/aKuw8UvC/tkJD7JZ/uBiqJa6bBVyW6KxVk2fhme9tvdRvJ5Tto6E=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3008:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3008;20:m9lQuPQWHqsThnAKuLy6rW+532Y3IRne+q4NwjvETqEQBsUr6NxB+yzD97SaEz762+iCcMqEv/XtAX5O5BeShxffgvKf1loSuMtjD/NHstuFOWIdgE0FILcaGgW15jWe6stp6xrYj8XglO8w6TMPempcVixrNRUqoOAnNb8IkVoOcoBJ7xwUZiETd5lPlWsMMmuF934IZBKFtu6CMYGkca8It7/KzoFVs/3hzqwoA2eR3ZlMfrMXYfRHxZFyrke6/7sRbUtiazrmTx87UM7gSLIGCKYDcxQGD63qvXm/0uG+1RQixvRWahucJqksOVCf/z0zgV3pykJNyFEPv7DCVbRpmulQmZaS8two8X4teZyeAQuU4cDcxBRNSGQFxDkEr26Sx9dAufPi2QnKEAmbf/3OMBwTYKsGseMbcvqDcKtdDYf5iUi1PeraoHykWTGZadtADexs29qAaECPM36PKpX+tVJRs8REWfCOJ2vMlS9HIdL2KL+sUZKAuwBB3mCYWFKpC164he+OEmohjAXUDs5pfBrqZ3qrsUAeO+ysiKFMpzlJ0y/P40PWftt4CPqiqGniNVe/bxuE9kDtws1K1d+cNGqSx9ui6Frjzc31LAs=;4:84COmU5rMh2x+rtEUS0zSIIXgIzFgOKCz6f5aPDIKXGOIOKBD4szQ7s/wS0eyJwUm1Ltk+UFtmejKZTD9HgnYOShzEyIVOs2PB/0tIrJGylEToUPXyVhWlyftggnm9oa1xfDjQY1O9HAyn1Ww8pzJRk9/phYkcdWxubkMSL/doVZOB9KjStrkQpT1zLAATURuz2axTE3Z/sl+a+W2Ls5WDDRE1dilIzNneatZw/69B0tfJlW8O2vPUXJ+y0yS7eGptbnusyJgnpV34+CiLDT7Q==
X-Microsoft-Antispam-PRVS: <MWHPR07MB30082373BB5557A114350DE58A7E0@MWHPR07MB3008.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR07MB3008;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3008;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(39850400004)(39380400002)(376002)(346002)(366004)(51744003)(199004)(189003)(93886005)(97736004)(16586007)(58126008)(6916009)(50466002)(4326008)(55016002)(2906002)(7736002)(6666003)(53936002)(5660300001)(345774005)(6246003)(316002)(25786009)(68736007)(9686003)(107886003)(229853002)(72206003)(81156014)(106356001)(3846002)(47776003)(76176011)(1076002)(486006)(66066001)(186003)(11346002)(16526019)(386003)(476003)(105586002)(305945005)(7696005)(478600001)(33656002)(61506002)(8936002)(42882007)(6506007)(53546011)(33896004)(81166006)(6116002)(23726003)(26005)(52116002)(59450400001)(956004)(8676002)(446003)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3008;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3008;23:vxncuhutooyIZu/kjwTz9FqZW8LteoYeEgbQlDB59?=
 =?us-ascii?Q?82RkbU9AnVwtmIqMe7fjTq+hHj5zK7uX8nnMPdwFTQYYNktzO+uxcVyz73Ui?=
 =?us-ascii?Q?SFXEf7/F8nTmJbN6dLpXexDWY3aetFKv/c1OHg1kzGhJlLGr4AQRtb73mxXo?=
 =?us-ascii?Q?rJbHAKJbMN1H6XubuzdF8kQ4itjHhXjfw+Ol0L2cNvob8jvcnximCoV+PM6B?=
 =?us-ascii?Q?C3+7XA37QJPRRn/KWw6+4CUuyeWQoEbUi2TaGqEDInn02h8M0lp8MwiH3bI5?=
 =?us-ascii?Q?65hlIz1RyiAI2l2wpFpvcFIcgFFl3YyWDCLub59jOuMF0ojtzSpYtNjsI1iC?=
 =?us-ascii?Q?luLkW7JokrzL80wM9rRoov3tfFDCfI+CvoPyZJQlNRHqx+uSNjMZ5Y/u9fPt?=
 =?us-ascii?Q?0IzSyw8VnNYF/2NOt77VXhVWnWYebGk1WbGjQqTM6aagVAQU6w6BijKtqSSy?=
 =?us-ascii?Q?h2GRpzC3oRIK8CRhZlkvmpViKqQu2GigLc42xCGTBLKFnsL/HBtgdl1kYejL?=
 =?us-ascii?Q?rWG+FWOC/fgeRlzV28xcVkeAEv7ZKMHpBAga3fWR+73paWNNfV7kD43LRxYK?=
 =?us-ascii?Q?FRnQEWbpQwhutTaERk4JLgXpbjY1JU8P2tNV3ba16ZoC8eCk0VTI296vWnGr?=
 =?us-ascii?Q?SwOEJvNomPXNE1vYYcGsBh9mxOwpG27fVspTuqwaIWEfaeY/5bPgkyLfJ0Pu?=
 =?us-ascii?Q?dVer8WyqmZWKTT8PZQ+H7sLFxXcFE4SyRANGopR9IjF9H+fpGCFoZ1SrJXb7?=
 =?us-ascii?Q?JadRHTJppq39O0rnu6Gks8oDPlt7QlnR6NFgYQ2Dcxox0ormmY2QXnqz33qC?=
 =?us-ascii?Q?h/Oy9WqhWkLgpaQ4L+tHOnou2vhBWL2IfiGeMrd4KBj1oir9leOOcuBB+sS+?=
 =?us-ascii?Q?WNORTD90L54+nMytd28r26I8NxXbuoKAU0If8CGBp0haDJgddSsfTSbv4VE6?=
 =?us-ascii?Q?QZ19WKgtyWhcwOgntIlEWtuVOzBnt5mtg/ZWGKztpd725oYJkTbluN/TYHir?=
 =?us-ascii?Q?Bzda+7pTm7o2j4ptjzSt8ahlbSDyOazgtW/NEGO+/sRQe9SmGIa1bbUWLSl7?=
 =?us-ascii?Q?tNViGDQJrybt1fuTjU7dHp4UWXDLwQTT/BWWKJdUGZygMkpOtBuHWivMA3oI?=
 =?us-ascii?Q?QXTrglu/V/IeCzMwDNdHfMpby7XXt8ZSsQ2FPphbLFDPqrbm41kFyARsgUOU?=
 =?us-ascii?Q?BLlQfpZ8b/z5Nmv3zEQrVFxQCLKIY3JC0xyQjkt1IOwfFSsejrFWG3gSI9Tb?=
 =?us-ascii?Q?G+ZA11OAtU0t1h28sRupdZK2UXQxtkJDf9l8wpPsClTFPM6ej7r4p+zJ8LSF?=
 =?us-ascii?Q?etN49MBuXeLrKXtyTwcn7FxO4sGSLvib/mULkvQcr6MOAgXT0KDy/1Fd8K4D?=
 =?us-ascii?Q?kjD21XcBrt4syBQ9E08DTZcC4NZnNckAEV8DvX4h/yeUFNW+suvceERhXTjB?=
 =?us-ascii?Q?TBAcxkQ4sgFo0OjrR0XL+KnOKB3UgcvAfL+noeRfvcgNQ1o//w6?=
X-Microsoft-Antispam-Message-Info: HrEq5U9BN1ZomRp92i8fU0GfeEuC4Ffx+T9R7aF5QveuBBbvRh+rHRgU9KX6fbBj6NV8qar58NJd/X4r9rt6B/ZP1R/e0bu10HhD5iuj4qVGx2QWXcjkgtRS2m+8eOfeWOom1VlsAONJPeGb1uIi3dUHdajjPO0so8uxjh1z+2ifiZoxYA3C8OuxrXd9kiWB
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3008;6:27R2dGqwa3ZcmVOit80X2zXRgtMKtC8CrYRhlvi6sOxAX2IdCNmLPNaqwm3BlLrUrK/buYYZbEEmJr9zIEqwBk0LNwPEHWJfAAaw9xYqliTDOKuq3dd/t673aTrRB7sRNFMCHCirjQo5h7QIL3T443qY8PIysdxXCi2zusra4CH8xmavlayapc9VuiXNs4EZAg/A0GNEKNVYPjUyfiafZ//B4zOfC6g/PQQ0TQlvPy3fdaj50Ev36aHCRK5GkQPCKE7CAD1tMgzci7FDl48olvjBmsWnm2mFYQ1YjOSQ+bhsJQIYLeADdeWJxibFohIwtShmXlfNaVLbNa0DGKR0sHJXJOZxjuDvWsTbMXRSYKNPQm2NEDEyEyaMHh3Tec2265QJ5VMkBRvOJPBZJARNTMI9Rj6saIQ+ojiI9iZHLAciyiZNIycmoox3DRrE9g3Wz64AhCQFpdGrAJObAE+bFQ==;5:GDlDgXdE/jKNtX+E4c7+PSkcqLYzOm7XsI6MVTcKvyWvRjUSN+6U+EfYMdvaM2uOH4FyQGcFJItJkddWsiXi1mJOXB7PyEt932R8LkAhu+jVLwS+LS0ry5/VoKRlaf10ns+H0f2qoK+b5R1u9Xg+oCzqLe/1F3hxHznmqJqegKc=;24:JnzPSc+6w3Fvsiwun1VZHLhGjmYN/dwSy88XE/PdWIyXPJpZiab5nL/UUcLta5gGUxM1npcVCqgn0ic+oxUC+hIiaKniPNy10to7PpkKv4Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3008;7:ubjfJSE6qDAQTrEW549NytFUGtYT1S3PIsstqGeGjmdTmsEK0ZSBXi4uTY7FteXREZnbvwZt9GCqLERbxJuLtw+DW49rACSSwyUgRmqkg3lwkoppAfg0N1qCyp/qfxqD9YoU9OK1jMMwI7UpiQGSKUSCURe8AIAwpZo52sMiCm0zyPPnPnfUoYZ4U3LepGJFNsk40eUjPjae3AfrrG26GWacjJIYev2f7kznesC/Mu1m02r0lPEJH2r3PRV0ggrF
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 09:15:59.3404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e70daf6b-90cc-473b-3948-08d5d10e4724
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for delay.

On Tue, Jun 12, 2018 at 03:25:40PM -0700, David Miller wrote:
> From: Dean Nelson <dnelson@redhat.com>
> Date: Mon, 11 Jun 2018 06:22:14 -0500
> 
> > On 06/10/2018 02:35 PM, David Miller wrote:
> >> From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> >> Date: Fri,  8 Jun 2018 02:27:59 -0700
> >> 
> >>> +	/* Save message data locally to prevent them from
> >>> +	 * being overwritten by next ndo_set_rx_mode call().
> >>> +	 */
> >>> +	spin_lock(&nic->rx_mode_wq_lock);
> >>> +	mode = vf_work->mode;
> >>> +	mc = vf_work->mc;
> >>> +	vf_work->mc = NULL;
> > 
> > If I'm reading this code correctly, I believe nic->rx_mode_work.mc
> > will
> > have been set to NULL before the lock is dropped by
> > nicvf_set_rx_mode_task() and acquired by nicvf_set_rx_mode().
> > 
> > 
> >>> +	spin_unlock(&nic->rx_mode_wq_lock);
> >> At the moment you drop this lock, the memory behind 'mc' can be
> >> freed up by:
> >> 
> >>> +	spin_lock(&nic->rx_mode_wq_lock);
> >>> +	kfree(nic->rx_mode_work.mc);
> > 
> > So the kfree() will be called with a NULL pointer and quickly return.
> > 
> > 
> >> And you'll crash when you dereference it above via
> >> __nicvf_set_rx_mode_task().
> >> 
> > 
> > I believe the call to kfree() in nicvf_set_rx_mode() is there to free
> > up a mc_list that has been allocated by nicvf_set_rx_mode() during a
> > previous callback to the function, one that has not yet been processed
> > by nicvf_set_rx_mode_task().
> > 
> > In this way only the last 'unprocessed' callback to
> > nicvf_set_rx_mode()
> > gets processed should there be multiple callbacks occurring between
> > the
> > times the nicvf_set_rx_mode_task() runs.
> > 
> > In my testing with this patch, this is what I see happening.
> 
> You're right, my bad.
> 
> Patch applied.

Thank you for your time.

WBR,
Vadim
