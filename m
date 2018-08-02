Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBACEC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7447B21571
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="F8C+DCYB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bBmZIPCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7447B21571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbeHBXTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:19:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52180 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726881AbeHBXTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:19:10 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72LP7gi009310;
        Thu, 2 Aug 2018 14:25:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=facebook;
 bh=aqMYM8IKkZd57BCg+ZpY3JuqyScTG5520XVCQL13ZdY=;
 b=F8C+DCYBmeBM04z9liZEMcR3i4Lw8TFmm5PAxYsAmBxJok+wNlL5EjD74P6eSPvn0J4N
 rIHM4aWGUWDtK5+22ibaY4EXIPHJ4GCuoJgz/X7VCX8hL+USabB6ODdCsiZS94GafIV/
 qQcFhplLTu1QdEFpUqGc/GvMBPZ5SGXbtHc= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2km99q830d-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 Aug 2018 14:25:48 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.27) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 2 Aug 2018 17:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cfSDUdJEF+CsI6E7Q6IdpFuMED1mInD/+j3OuMvNlw=;
 b=bBmZIPCpVpRedIFhdSZpMOH6Rrwp7aBDKq5vWN+rhaVFImE7jddw3Y3b/jPkSCGm5CCypz4slWBMHffoIPMeEXSPV/vJ1umBEqrpJwz3GIBLWbDArAFGutcklnEMuN0ObmRzCHlRcDiOGsS5TQ+d6jVMKp/b0qe6OTG/D7lhdIk=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::4:6653) by
 BLUPR15MB0162.namprd15.prod.outlook.com (2a01:111:e400:5249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 21:25:43 +0000
Date:   Thu, 2 Aug 2018 14:25:37 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     syzbot <syzbot+25554ab865a12b51c66f@syzkaller.appspotmail.com>,
        <ast@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in bpf_cgroup_storage_release
Message-ID: <20180802212534.GA17831@castle.DHCP.thefacebook.com>
References: <000000000000f3b1570572779079@google.com>
 <1b3dde38-549e-43ed-d3f6-18b451444d2f@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b3dde38-549e-43ed-d3f6-18b451444d2f@iogearbox.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::4:6653]
X-ClientProxiedBy: MWHPR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:301:3a::15) To BLUPR15MB0162.namprd15.prod.outlook.com
 (2a01:111:e400:5249::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e9e96c6-91c7-407c-103b-08d5f8be814b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0162;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;3:p+jzuwkkuS8A2pkHwItdHixkYi7203fnj18z/lPdDjEfpI1+KlCsCKrqHdqkrjgmrFrZHqp/ZNZGLYe7syIqCNWK/OfrdOB8ggTbrptOSac/ZIws5qvjNe81zA3FHh/UVV8jYUmp1pPtOaETLd2qkJHzudZfCphp3raYjjqEt2jL7xcdB8guoOKAkmlFnNhiNndxj7vfw61Y4zF5hJoejn+8llNBvNVGLKgPgsX8lWsutVRjzxwiSY3dlOJ4f0JP;25:vHimwlqxFeh5LgfEZiEiCS5RP2EGyQbJ769Yi24p5To6jds162gMiPjoj9ykf/i2rNL1ATeqGI7wtJzuzNNaNn2MvJ/35IPe4hg3UD/r+HG3QWQnAumyDpgaWJVwNbHPiUMDw784dvedD3NJ4I7XvrzzpwpUjgH6/x2kMs4dXO9mExGQRtgCJ5ki1hmzWyB0cqsXovGJapJh8X/SYrgZoQx719xcaXlKtG8oxCsiqby7rluVSetjlhfsT9SY30OP6tmD0D6YMM/+U7H2E2p1lLPAtgAG39Kyo3Iwxg8idU7WdVk1pKxZFYOwjnYwsdareh8Uv2Qw2djAp9o3AJqM2Q==;31:Phli5Wje8cBe6iJO5FeZBloQgQo8TTTbKC2HIu8UOk4EJs6dB7iQctkxFxzufXbgWHAMcrsUSk32YSangRHUVeV4ncmjrnY5jkznC3u16HB39KdB06lAvjy1XjXBTTYRbb06oEkoBhxsuQuf7WorwxDi6bPYNxukpNUDkpUskorQLsLL/6/Pt8Dlff840goXIaqtyb81gN5ctqk6gco/LKFROT5i3RsSV6n215Fgdec=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0162:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:cnY/yiNzldsJxCO2WSLZSEpZOAiM7JvzvFGBXKIAKYcS+3F48XzpxQLCeMYcpMnQSgBeI7foVB9wJXDEp+9rj3Lv9d9AOQayF1QOGIHKtE1MO9LXYJMa73ZMBcvSMUc5fhf9Le35XbbQmCWa2vkfpyt5G0sAS8XARF92uC8AjsFwBLp0roJfOIIkDo5JK2Km/vGYYDAO+QfxBvo6OMvFqy46Y4IO36xnQeIukC2zb36r1+hDuHu+Yr1/kMZGLT3/+ILolZFQ7CgHzcwuMxsjHeaZ8SawndRoM1YyADeReCzssIBE++Nmm5k//K3NQ/4zHO9F36ZH2xIaWVQO8Nu92UIa3J0gl5hqaD/bTwY9g6oREdKQ4dzj1yJiHDlpyus9Pa4mff9F/rjabiu7loc0E68Okd3N6HeprBGhhTXc8UNBZlk6QYjI3Dd7DeWyotJo8sPXK+YoaiXhOSuIM9L1BiE4cYQZP4++E809ZrsHebqQSIa6bcdzbtgd3u/qxdgH;4:2n/ylxwXDWTE3HVE/S1DtQX3GHu9kdebbwuiM0E4pKJOvY3+qgbCHRXGlhCyOPG99d6fSCVEcYs+y4Jjga1tMmayT0YhsfkrOfExF4ZbkhiDxywkuWNloYDN7mtpGKZQqFJ82ABmZHvekP+QiJ4WtpRWD3j66AS3kr/R0fRL4Y4Z0SufNHUnmUL2uLKjwOVp69qy9zG2qD+c9AFgZyvDbMWQiUx3qFlLIGclU/fa6xeU5zsEypmiFiKh/93Gx4FY9ZjfuxjzWBAIpEisY1QDGwDDMNKWzNZ1mEqI2ClIJ2xqeZcoh2sILLNTPI1OmIzx
X-Microsoft-Antispam-PRVS: <BLUPR15MB01626178907BEA2B4D42EE08BE2C0@BLUPR15MB0162.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(10436049006162);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BLUPR15MB0162;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0162;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(55016002)(6916009)(2906002)(33656002)(58126008)(476003)(966005)(5660300001)(52396003)(316002)(486006)(53936002)(6246003)(6116002)(4326008)(229853002)(6666003)(105586002)(8936002)(68736007)(23756003)(106356001)(25786009)(1076002)(47776003)(11346002)(305945005)(86362001)(446003)(97736004)(7696005)(9686003)(81166006)(16526019)(8676002)(478600001)(575784001)(81156014)(46003)(186003)(7736002)(52116002)(386003)(6506007)(76176011)(14444005)(53546011)(50466002)(6306002)(2870700001)(18370500001)(99710200001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0162;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BLUPR15MB0162;23:YAXagck/iEfidg/ZPOsC7f3wQesvqOI/1IVr7q2?=
 =?iso-8859-1?Q?/plVFIkOyjYZ95C2bPepQGuUfAy1sBCfeLJyBdxqrpEWr+QKPnA+gLJv1M?=
 =?iso-8859-1?Q?R733U/gPOvmxAbAq6TA8+CDdJ7QaiTrltORaGYGLlPMibL8ckbjZpgpfOt?=
 =?iso-8859-1?Q?Nhc8vWDg+xDR5nhHB8cnGN1rWFqmumAbr5g1yfYPFQMTnBd76HhgI6Uzx3?=
 =?iso-8859-1?Q?mgjSuicXE8HfOxG1+plJf1PkfIjC07Hdw/PyLgNix3pY9vIYn6YboWB3Wm?=
 =?iso-8859-1?Q?GDkooMD/punLfgGujj12LWBOsjTj88rSP2p0o+tBvd3iv1J4A6tZX8mbr6?=
 =?iso-8859-1?Q?QXtwNYxQm9QJQ3aPlXwQs3vwIUifQYdiKYisJN5RZ0BMSGKrJ1eERLNsI3?=
 =?iso-8859-1?Q?cfzGAYJDkmVM/4iGEX6hLIvU2daOm3bJMRPnsTl31SeGM+vWan69fvlhCA?=
 =?iso-8859-1?Q?VRdnEaNCtVqntCGUxawsVYcrHOSCYcdT7Vuzo9WNDP4pwc0dt4/HuxkB8y?=
 =?iso-8859-1?Q?HLEYPqbUhkL3lCi2sXAzzyokT9xYaQ/BOd3ELXN6FZ0h30wQRG77t9oIWB?=
 =?iso-8859-1?Q?FH8hd8/OsZu+pFa9LWtS3P9KZzBAQtOM6wOV00eQVihSKWZUWremdtAZVo?=
 =?iso-8859-1?Q?AtZzv4RYwQhlEHMiR83L1nTLmIml+/ma7WQKPNRU6Z52u5qlscVupHlxzK?=
 =?iso-8859-1?Q?KVDoOiAtfD6Th4YNjhEq4CNJXpCpU7IEBGTwldGAQcf4vL7L0zt3Nhe3AC?=
 =?iso-8859-1?Q?bpGzw4iQF72xcyVP5P8XTNne8oQWIVk7LYUnA/GKX1dYZ7LnDz7rBStrUv?=
 =?iso-8859-1?Q?n7CnzxRbwgWIVl41vCL8WbaQcDJY2HJAwsPF3ixyIL9neGmGd4qMFl9cWr?=
 =?iso-8859-1?Q?CQmAN6UWxY14+3RKgXv9Hcbnjk3tr0TVw8H2QropINCbfoLyoo9HcfLTB7?=
 =?iso-8859-1?Q?DafnHiXaDpdQSqVnSUr9qNA1PecqUgX+nWyd6oScf/wq0lEmA1oU1f84Je?=
 =?iso-8859-1?Q?PkmXTBlPGz06bVLf2FpHBjA9Y6X9skH5bcQ3rKCiZYPmeWnW7dxTaDcftp?=
 =?iso-8859-1?Q?unQIP6vHIEMLIAr8vZF7uVRmtyF6KAZ7zDNN/Pz1NKHf5I6xEjRQknAk3N?=
 =?iso-8859-1?Q?Xj6Y6T+1lY0pr2jtGq3hJxe0Fe1nJjGECgi4sE1jlHChxjK8lJ3IKJYFyh?=
 =?iso-8859-1?Q?ddgOOXVsur0zWE57TzCuE1iENoeaTDGF2ZUvWktYMaRoJYlvjIiZaghiR9?=
 =?iso-8859-1?Q?zc4Jsp6XKq3RW2tPu/ezKtqPSs3egwCxWgwb2klkOSFy/s18JEJNpGkvLN?=
 =?iso-8859-1?Q?Vcai3J8GyffnbgHk2X1oPpi6c75r350NSK91QRmnGHFRha4P6lGQSWcgRn?=
 =?iso-8859-1?Q?MeTUfY2xCJq8/yU0JwQk54tmAwp7igr//kV3XrxBIMc5zqrRr6Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: k2eLaB/JQvPXNapGc6sgj3uVWlbQvxH38RC4N+y/YbHdeMyGe8I5sr7OnsxunO0oubgV73/0jYVmuCqxvLB9Nh22YxB8RSMRsuGXIpAcxmsdwfUpxWd5+Si/70vVzuoRB8oKOD2oOt8CgAd6PaQaz7UNX+SVgb9ripezbU6kQbhaIUZWbK8p44LKJykBSoq1XY6q8hlSotmleGOG+Smr2PYBWq5p6sVuHMSl/tlLj562r7Ro+MIgthxQx6CFUQk3fJS3UgWyk1eF+GCuGb7R77TxX4Xaa75cF3dmQgyHorsImvnQAwUltIK93bJ+0StUYgcilhXmmot1opvYvv6/ckqVsmkm9aa0D+AbQtEJjhQ=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;6:MhQ+FUTs2WEtR5tieUsH70/sryxbka1kWR0YutJ56q3uE9iAW3BfjQNmh1xIwcnfskHSGeIPOymAGUu+SY5ki6Tp1TSav6SxaT+jtbd3YQE/4F8+iUnyOEp/YGPOyZjXtpKMraxAHVhAQOED9vlpAvsGdmlkHub7YYm2A8GVl6q5AomNE0WXLeVWijUkP9yo/hsXLicPnZUV3Eqg4L76hxTlS4L1eDftYNlG3qiCQAo0CMO52FwYChDs7QgsE63TnynbeVeRLa7BIs8GlvAtXX5xwOLIvkgvJOXNsNVpR/OxVmkjKsde2W2FsI5WWaNB2ptXvgTK65vU4n/fOaHrjIAfvAcaNR1ftTln90Lu/BlxjQCGjxRCcM7xf54SldbalIBvYdJDFnT1mrKa7D4687wYelxLyDsX+m3a6Vbn20EBiKcmg7ZYevfvGFImGEJ5Ggp8m35CEWGEgd+urzOfWg==;5:67eKnFDH4ZC7Z069v59LFj9llo0aqVlBwwEsMDQiHTGzyT2NyXvMileGZ3oANuzq8qbKtp+da67ByTa6T7+7USdtP6M/V5mSqMqrSa9v0G9HHyPUVC06u/ybwabZLD3bwHUpAlUyMJ6dFCWS6uzVRpAJXXgVco2+gq7cofRLkbs=;7:YbG6eJns4X+09moa+7JoBEzeFnpEaKraeeqhYCLsHeUZbyIzoq2YKBtjP+0e6+GNTwL2SkuOWCEH/VFBMp4v9K0LyBfcExqr2TIXsGu/oGlGXID7LZpxcazQdEe5M/L0vnmqmY47s12wR2XTb6cXBep1WF7GOxUz+kWC9mCHTBhupzSyCgIVWZ6d7s74JCqwwcgEuMuQGC2vym6LKWLFgzQy2JsojA26FzbOy8ckLdWtb1zM1Evqm4tGf7rOcsaE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:YA7inTPs1bTc3ZUYmij+czVAR+wx18vgCLynJH7HybV0NktmTOwyMgSr4Iounv3RGEWnkE1jEXu2xFB4I2VSf1Z3l43WDUgMUQ8SPYV7kH8o/vHK5L9bbEUAs7kmtNrbnGGdf/PGl1lZqfx3CXA9IApD3Sxrfg1STkpCscpnRIc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 21:25:43.1041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9e96c6-91c7-407c-103b-08d5f8be814b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0162
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-02_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 09:23:00PM +0200, Daniel Borkmann wrote:
> [ +Roman ]
> 
> On 08/02/2018 07:59 PM, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    fc2a3b5dd618 Merge branch 'bpf-cgroup-local-storage'
> > git tree:       bpf-next
> > console output: https://urldefense.proofpoint.com/v2/url?u=https-3A__syzkaller.appspot.com_x_log.txt-3Fx-3D17a6a1c8400000&d=DwIDaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=EDSyTXUjQWi0Wr-pal_Z622tnk3UnxrZ318k9Tct4wQ&s=kNpA8CkCvXgMPDNNfqgkqDlGShzYMrSvH1AWBdBslJo&e=
> > kernel config:  https://urldefense.proofpoint.com/v2/url?u=https-3A__syzkaller.appspot.com_x_.config-3Fx-3D3bfcc1651962483&d=DwIDaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=EDSyTXUjQWi0Wr-pal_Z622tnk3UnxrZ318k9Tct4wQ&s=PYjD3Jqpwgzv3cBV64k8EAbXwdolWkrrrcanCfJU6KQ&e=
> > dashboard link: https://urldefense.proofpoint.com/v2/url?u=https-3A__syzkaller.appspot.com_bug-3Fextid-3D25554ab865a12b51c66f&d=DwIDaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=EDSyTXUjQWi0Wr-pal_Z622tnk3UnxrZ318k9Tct4wQ&s=FQHY4B4Ok0SJh_C-lkToT7mX_Ehj3NSHe6Fe1UiL--Y&e=
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syzkaller repro:https://urldefense.proofpoint.com/v2/url?u=https-3A__syzkaller.appspot.com_x_repro.syz-3Fx-3D12c4b9b4400000&d=DwIDaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=EDSyTXUjQWi0Wr-pal_Z622tnk3UnxrZ318k9Tct4wQ&s=38j2eoBTEgFiU2FlYHK86YXiVNEjxV6n3ug4tlAZ3MQ&e=
> > C reproducer:   https://urldefense.proofpoint.com/v2/url?u=https-3A__syzkaller.appspot.com_x_repro.c-3Fx-3D13e9d6f0400000&d=DwIDaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=EDSyTXUjQWi0Wr-pal_Z622tnk3UnxrZ318k9Tct4wQ&s=R75neIjoG9ODJgTDAUAfWqORwwOVX0k_cz7NsKyF6qw&e=
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+25554ab865a12b51c66f@syzkaller.appspotmail.com
> > 
> > ==================================================================
> > BUG: KASAN: use-after-free in debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
> > BUG: KASAN: use-after-free in do_raw_spin_lock+0x1c0/0x200 kernel/locking/spinlock_debug.c:112
> > Read of size 4 at addr ffff8801c4723644 by task syz-executor865/9746
> > 
> > CPU: 0 PID: 9746 Comm: syz-executor865 Not tainted 4.18.0-rc5+ #68
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
> >  print_address_description+0x6c/0x20b mm/kasan/report.c:256
> >  kasan_report_error mm/kasan/report.c:354 [inline]
> >  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
> >  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
> >  debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
> >  do_raw_spin_lock+0x1c0/0x200 kernel/locking/spinlock_debug.c:112
> >  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:136 [inline]
> >  _raw_spin_lock_bh+0x39/0x40 kernel/locking/spinlock.c:168
> >  spin_lock_bh include/linux/spinlock.h:315 [inline]
> >  bpf_cgroup_storage_release+0x2c/0x110 kernel/bpf/local_storage.c:276
> >  free_used_maps+0x81/0x200 kernel/bpf/syscall.c:961
> >  bpf_prog_load+0x17ba/0x1c90 kernel/bpf/syscall.c:1414
> >  __do_sys_bpf kernel/bpf/syscall.c:2338 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:2300 [inline]
> >  __x64_sys_bpf+0x36c/0x510 kernel/bpf/syscall.c:2300
> >  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe

So, it looks like we drop the last refcount on local storage map
from release_maps() and schedule bpf_map_free_deferred(), which
runs prior to bpf_cgroup_storage_release() in free_used_maps().

If so, here is the fix:

diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index cd0b115c2395..fc4e37f68f2a 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -277,6 +277,7 @@ void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *_map)
        if (map->prog == prog) {
                WARN_ON(prog->aux->cgroup_storage != _map);
                map->prog = NULL;
+               prog->aux->cgroup_storage = NULL;
        }
        spin_unlock_bh(&map->lock);
 }

--

I'll post an updated version (v7) in few minutes.

Thanks to syzbot team for the report!
