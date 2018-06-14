Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AA463C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BD7208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="SPULXB/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BD7208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754999AbeFNLKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:10:32 -0400
Received: from mail-cys01nam02on0042.outbound.protection.outlook.com ([104.47.37.42]:43648
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754782AbeFNLK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYmgGoVdaQUrqNdWjm2m7zK+vQw7whWxfKqqy21N81w=;
 b=SPULXB/KIkUcdGy4mAmaouOXqsofUSEdTm2kTI8P/rYoiPQ8RJ0RjJ5deo6CKnl8ikcS77Q4FJU9idKXj/RRAbitOAYHy68CzwtjOYT1tGy8nr+lPZnHq8G+yatjdEKlgl6lZrRrQrfX9te1BWUYVX9sd9NZyKuSx2SLgJRGq8M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
Received: from localhost.localdomain (155.4.205.56) by
 DM6PR05MB4586.namprd05.prod.outlook.com (2603:10b6:5:9f::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.12; Thu, 14 Jun 2018 11:10:20 +0000
Subject: Re: [PATCH v2 1/2] locking: Implement an algorithm choice for
 Wound-Wait mutexes
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20180614072922.8114-1-thellstrom@vmware.com>
 <20180614072922.8114-2-thellstrom@vmware.com> <20180614103852.GA18216@andrea>
From:   Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <b84a5ef9-6cd1-7dc9-a51d-cb195cdea83c@vmware.com>
Date:   Thu, 14 Jun 2018 13:10:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180614103852.GA18216@andrea>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR0102CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::46) To DM6PR05MB4586.namprd05.prod.outlook.com
 (2603:10b6:5:9f::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a49d8c5-7e77-46cd-2746-08d5d1e76d56
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM6PR05MB4586;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4586;3:AdT/di1vqUIjlteXCJTrMLA/PcxjRBf1TTP1ELTb8MLWApM5K8orTO4QC5YZ6s6ck5fmOKR/s3LnM4eVeFv8OEDJaCbO08ftVX0jDGS8P9Z4ZKGw2wywr5gbmwY4d5+AyPccIL6/Xryvsc5P3mla8bnHROMHmA2hya0n2XNdHtlkBvcXN/oGz2jkP1QMvtbl7DJLviaiK/heODvaDh0EedSgsSpJhMH+u87Tj5XBPpqTJJPkio1gn3EFg/x9fRYk;25:fMCv714SMKN9sjlnwPV4HVEJVlCiNemd5kowR9oMzajiryIJzVbrM5nZUMUG8J9wLtkMRPEhM7d7ZhLBV2uUCMh+j+RXzBQsaXuPzWK/bZigAIVXzIJJ7KhzQRu7KJbrjPHF04e9EFwMc0zTUEqlCBkW3w2OB/pUqydCi77nbKk5jTSovCdz1zQ4qEWCgUsPcwlRPSoWW30PiQht8rFqE6gRaIuGvDXzMXDNgf3bDfSpOufCBNVzath9Darioy8/6labxME6v61SHhfONrnZaMHbc0w+7/icElwO/g64ge8KAF/IoGYvF8LS1HeUzw5SBgBKch7kRTEbiDB0Lq+BCw==;31:K1sIABUbaZi18oOw548C1+VrTMcdTugDwNdEwpyEl7+AAZ0BG7xN7UpxAenK1+8oau0TUu3VPxOo0VMN7f5tpVlIX4nxnE1wVcmto8QIXzF52CShmqiodpKvhdh40nBYRCO3BSSOnyhpu6z4u1fqdg3/a9xicWuOShl1tCYC+g/6BgYBgI01TLiSfJYzjbEI+a8gmpkYdVKnuN4HcLjqgn9+7XYMqOK+a4qB3UPeJLo=
X-MS-TrafficTypeDiagnostic: DM6PR05MB4586:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4586;20:A/hQyCa8P/qWYvmnYoAmIIwIzy6DFSMZE7COfZdJ1z/5bufIQAX+rkOohrsRRCzYx34VfuP2RmrCBRRQtN+DLZ9OgHQ5Kix9hwBbd+DZXz8FR8XlMyMJw30+HfqjsZF4/buRn9usFf/0aknKHhg5diQONQNBAxJSxhsK1kFmgKep+MRIxEUUupar/S4xzxn8LLneC5VhsF67mbVupTfB8cYDeAI1DmJolkvraoKfUgesBXXAxBB6j0hSTclUc2F8hJBkVGemnXS+3RWUdVth9DBZ6IHUDKqqbjJmnoWo0QlwGrrUbCtPm/VD5gNlw6Zn0gFdVIJ4n4l+zM4lhMdreM0td5TuweNlTymxZkouRKVR9T5pnh+QwxJs7M8QlkrT02mpgrKVCyZ1MFUBLjk+G+l8W3mZtpb7d94dbWANlxM8dWKHKaPig6QH+MOqxbrlUobuIqk4Kp4ZoVbsRX0+16wVyUtjfr9q0mXzNmIQuOUSFEx6YAW4pDRJKHU6SYLU
X-Microsoft-Antispam-PRVS: <DM6PR05MB4586DD7A92F82AF030B8FAEDA17D0@DM6PR05MB4586.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150)(9452136761055)(1553240931313)(104084551191319)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM6PR05MB4586;BCL:0;PCL:0;RULEID:;SRVR:DM6PR05MB4586;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4586;4:V0TAsHc+SSoaV4nULHupp3Mq3Pzor7xoIOwPMEffBrFB1JWEAd0ZXtVP/94nLir0RlYiCWLbk8H8TXSwi+yzwdQCczKnQPl1B6AlqMZcHHAflQ6gs5OgAU0yAYvX6J78cn4nWbE+Af3edvtPeiQR/cWxXIziwtG+blJ6ZS1DYD9e73lqQF7Y53hMMAnsO2AsRACPQlZ45wid3fx4o+bOkSXnOueT6ovoMB5ogEAFKCKFzDefcO8qjI8e5dgZ7iUxM9JENhp2QzFbAjOeQ0xXOqJpcf5hSYwW2wVDhXO2m1CI4p5Yl3WsY02gKZcM+mv3g7dUeFLEDTw6mv0CGmfkeihilNP5nNCZvNKwGfYnxdEVrQSuCamtPej+hhMqVHMVWHaozLO+DQUvN1043cDDYLOLl3SOXBb3NZq1CzsA55cPSU9EEqb60oouQxe7UxjR
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(366004)(39380400002)(396003)(346002)(376002)(199004)(189003)(3846002)(6486002)(64126003)(7736002)(305945005)(68736007)(551934003)(16526019)(50466002)(7416002)(186003)(230700001)(58126008)(316002)(54906003)(6116002)(8936002)(81166006)(478600001)(8676002)(81156014)(67846002)(2906002)(6506007)(386003)(59450400001)(97736004)(26005)(4326008)(25786009)(76176011)(86362001)(6246003)(575784001)(2486003)(52116002)(23676004)(6512007)(52146003)(65806001)(65826007)(229853002)(47776003)(31696002)(53936002)(105586002)(11346002)(956004)(106356001)(2616005)(66066001)(476003)(36756003)(446003)(6666003)(31686004)(6916009)(5660300001)(486006)(53546011)(65956001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB4586;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjA1TUI0NTg2OzIzOllVdS9QVGM1Y2JoM2dHRXQ4dFY1MUw2VGM2?=
 =?utf-8?B?YXNDQnorMzVIQkIwcmdxL1pMNmdUTWdmdmdrVm8xcFZMa3NiUkJ0TEp1VHU3?=
 =?utf-8?B?aXNKQSswTnBLY1JDZS9RSjE5dmt4Q3hnMmVoMHJyc2VRVHdoSzFWU1MyeHIw?=
 =?utf-8?B?Q0U4bTVhNElISEFPa2VHcFd1WVEwcU5DbU84cm9JK0YwR0hLUG1KZ09Nckdq?=
 =?utf-8?B?NUJtZEs3a09GOUcyK2RIRXVtNHdOVlpvK1MwZXJ4Ti9VaHBhMXhGNkNsRXho?=
 =?utf-8?B?SUhXc21uWWpza2o4ZXdiTk1QUTVWSlNrUk85VWxjL056UmR1SDk1cHhwdEhi?=
 =?utf-8?B?OElENy9GTjY0MGNRWnM4a2ltT0Jid1ZoUXhBZjRjOC9hSUZjL0I3Tkx4emE3?=
 =?utf-8?B?SE44clRoYjZoMWJsNjl6RjVJbTNUN0dCTzU2aTU3aVQyQWF4VGIxREY5dlRl?=
 =?utf-8?B?QXlOV0pkTjZxQmtVMGhITnU2a3FCaDMrSnlHYXc3RjFObGxjZFhYVlA0NjlJ?=
 =?utf-8?B?Wlp0M0UxSGRvcHlhVjI2ZnE1U0ZoZkJMR3JOS1BYcGpjajFrakZnNWZFRDdO?=
 =?utf-8?B?S1gxSE8vSjlmRElIQ0w1ck5QMCt5TzZXMUZMazgxTjdFMUsxMDhjQnlmT013?=
 =?utf-8?B?MVRzVjFnTTdzZmNIMXRmd0h3RlMxU2hpcFBPVE5yNCtkNW15S3lFY0VmNHNQ?=
 =?utf-8?B?MkpqQXEwYnErWlRFZ0t1OGtIcDdUZFlJaEtMemtzZ3VONmd4UzRJTDBrOFJB?=
 =?utf-8?B?bDIzeGxSM1IrWlc3SWhuZ1VTTXptajJGTDlaTCtzWklNN2FpTWdsREgya2Fv?=
 =?utf-8?B?ZUNjY3JMdXd1UFlwWFgxNlVsM2ZuVzVIQ3dia21uc0NSSVNKbnBhMUI3S1FU?=
 =?utf-8?B?V3Vxd3hzUmJhZ1Z2QUo2NTFyMWNsSmxtQ0RyTFRxY3BPRDNGTFd4ZXozWEhp?=
 =?utf-8?B?enorS3VuUlFNcjAxbG9kTkxua1dqVG1oQytzdU14bytnNHJldkM3WWJjWFJ3?=
 =?utf-8?B?NjlVc2pMaXVZcHpDdU9xa2tNMFA5WUk3ak9oTDdaNStjTXVUeWxYSlVjeHM5?=
 =?utf-8?B?MXVkeWJKOHFwdTJUYzZSL1I1VFpoRFViS2xBUmRVcFNDS2IxNkw5V294SUJJ?=
 =?utf-8?B?NWdBa21XMGVZa2RNWEVzc3A5ZHQ5TGN6STlwQmRESVBpMnZNVUhLTmgrL3NW?=
 =?utf-8?B?TGlubmdsRE1JeGhjLzU5amUzVU5FL3h0RXNkR3FWVkFrU3RmRWp1SE16N1p0?=
 =?utf-8?B?YWVXdURRQlNKWUhVOUdtbGo4WkJrMElvb2wrUG42aHd3K2JPL0pWS0NvcVR2?=
 =?utf-8?B?N21OMmRPczRFb1BrTDVQUVNQU0tZSFdQZ0YxYVhqK3NyZ0c0cVQxeVNuZ2Ew?=
 =?utf-8?B?c0hrN1gyMCtmN3pRVUdWS3FRN2tNRkJPdjlRLzEzOHl4TWRCdlFFMGw0WnRN?=
 =?utf-8?B?emVJYTE3Z0tqYkVqaE1GOHE5L0xQYTFnZjVybDVrY1V2SUZxOEJBYy83eTEx?=
 =?utf-8?B?RWVoWUNmaFkrbXJOTVFJTUl3c3Uwa0FabWFKUWQya2M3YzFNS2Fxb0dnZ24w?=
 =?utf-8?B?UmRZcHFwR0d0bUlXZHBrY0Ztc1FIVmhVY0dIV0JIM3lhSDhpMXJYcmdlY1p1?=
 =?utf-8?B?NVpMeHRrU3FzV0xZQUtnbTFYY3dXdk9zZzcvMzB0T0NkNGtzcXFHdC9lSFdH?=
 =?utf-8?B?OWIwczJJWVhwS25vdWNKMG00djlCelptUWF0cFVSam51amdPOXhWUFpUbmE1?=
 =?utf-8?B?cFRhckwwalFVSkN1dml3dHJHdm9hTjRHdGE4ZWp2VUg2eThURHpNdisyKzEy?=
 =?utf-8?B?bzUwN0RMeGswdUtRbmE5N3YwSk9BcUJjejdVeFJtVW1rRDY2dzhZdkZOcElM?=
 =?utf-8?B?YWdVK3hYZDUxbnFuRFhhTEcrVXEyZVpvanlGbjhXaTZnVUNMQXdNN3ZOV2NF?=
 =?utf-8?B?T015Y1RrMDhZUmw0M2Z1QW0zdnhtbnRXb3Fna01IS3M5T1U1aFE4aHZxNnRV?=
 =?utf-8?B?Z2VQQ2pXOEJvN2tRREJKMkpDcmZGSWFtWGphaUlUK0lyTDlNdlp5K054dkZU?=
 =?utf-8?B?Y1I3bHNPUVk3NExPQnQrejVvMlRnSmVXdkRDRlh4SUhMMnovMVMzc0w3bVYr?=
 =?utf-8?B?UEE9PQ==?=
X-Microsoft-Antispam-Message-Info: EMg/wqp/XUetPJU4iwFRMmrI6Vv8jX+MeCMQanz3/EYFxaybpQ9skAgfAoJ44pstNBsNU95qMNgsUdbB4UmlnCmx78/GOpcOrAE1mVIQB9hKJULAmTOueYNo3nI5n4szcQgh1zqNNGUcEoFxFd3rKDOl1Km5B+AHBUrRl4BizZSrQcZff0nuIha8shiEfBms
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4586;6:N5EegBuAo0mjVdmyVZTKIQKqk8i/bm4CSyNUeEyoCuWgNaRIEHBqYPx8ctSTyfKGpt6kvGlaoYXMCQwXFjXBusrupayhDfax6mjXBE2VYExZrmmcZum+FpqUE4TbJkQDzKfSMNpB/B3PMeicZ8+2bJccNAWdWRyBtsFSu95IOGiWwjvFN7ixIlXFwXtAN0V7a3bMJp3Y03xwG5WgRVEd39Klyst3dbUEXGWVexR6yhKcqBIktaGpFWU/+SU9b0Liu2AsoSFfbM2FzV5Jfo7F0TYqwLB8Kjq78HKkwO4zUcU+O1oZfUzlFvzZKS3Ps6VgyEE/lVOYVaNo0Qm4eCmUMLfweuv33UQc0QSj/5ouviM7xsZMV/jEdvxj4EGPWvk5n3HyBckthPnhhI5wIIC6K8wkidzIFyxFdjThTI1KkcQl3Su4vo+7YfLQrGYQM5i5073Qn2/v3aDDch7wt3xxQw==;5:2JXQuD4gIY2wdwFHeDqPzA2oUWr4Rl0WpKpCbjXul7wl7o5Q3L0mTsUaVLDix7m98KRmDs4C9gVdCVXC9JyK0GX1m5cH6/iurxRr7kLQWwmrBw2LB2nejQqWdob1A+1lQvCT4YXzv+0bYYDyoZti0Xzr+fjxn5xu9STdKgIg7jw=;24:MeqtsKQtzjGbbXmnjxjxJkWvM2O4qUEU/0ZcGjeR+djycoSPsXdbpYDcmT8JWnW4mdM2hrAjhXVyXIGeAdjOcXcYTMgls7yEMvwHjkc0VPM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR05MB4586;7:8x2xr6GeQVCZ5IhAH+RuFsVy7xqJhQ/mOmTHT/VTfdDN3RNlcFFUnydRRal1Vo7L/S24Gx3/7tGnJeBdc8Ld4kWoVwcb4wtp2dpbKWMDXhrAr4yl3WbaSQlaO27cCKsRt1JILtJFpPY+Hd66kwPR4MRAk7IEtp3qoxdVPQTcKoQOFiDn7zoHgdisH96hclPCXaAMHTwZTxVAml316o0tDfAHs1z4KfRmE/gTDPTdXIfOViJ68Kr9VEWveVCiCJWe;20:g7icrOoibeLnxBldjqj+MaYq9ogHOtDlwNEo9Bl2xVznHgyxO4XFhhVAu2lEefg7WgQmNXuKRWOQTCNAVE2mdB8e41mm726l/KhF6BYaQLePsKsdmI0y9Hm0lqUBOjINQ9Bi458XniQf7F55pH3r4n3cex02lIapN3jaBrvkRLw=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 11:10:20.6690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a49d8c5-7e77-46cd-2746-08d5d1e76d56
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4586
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2018 12:38 PM, Andrea Parri wrote:
> Hi Thomas,
>
> On Thu, Jun 14, 2018 at 09:29:21AM +0200, Thomas Hellstrom wrote:
>> The current Wound-Wait mutex algorithm is actually not Wound-Wait but
>> Wait-Die. Implement also Wound-Wait as a per-ww-class choice. Wound-Wait
>> is, contrary to Wait-Die a preemptive algorithm and is known to generate
>> fewer backoffs. Testing reveals that this is true if the
>> number of simultaneous contending transactions is small.
>> As the number of simultaneous contending threads increases, Wait-Wound
>> becomes inferior to Wait-Die in terms of elapsed time.
>> Possibly due to the larger number of held locks of sleeping transactions.
>>
>> Update documentation and callers.
>>
>> Timings using git://people.freedesktop.org/~thomash/ww_mutex_test
>> tag patch-18-06-14
>>
>> Each thread runs 100000 batches of lock / unlock 800 ww mutexes randomly
>> chosen out of 100000. Four core Intel x86_64:
>>
>> Algorithm    #threads       Rollbacks  time
>> Wound-Wait   4              ~100       ~17s.
>> Wait-Die     4              ~150000    ~19s.
>> Wound-Wait   16             ~360000    ~109s.
>> Wait-Die     16             ~450000    ~82s.
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Gustavo Padovan <gustavo@padovan.org>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Sean Paul <seanpaul@chromium.org>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>> Cc: Josh Triplett <josh@joshtriplett.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Kate Stewart <kstewart@linuxfoundation.org>
>> Cc: Philippe Ombredanne <pombredanne@nexb.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: linux-doc@vger.kernel.org
>> Cc: linux-media@vger.kernel.org
>> Cc: linaro-mm-sig@lists.linaro.org
>> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
>>
>> ---
>> v2:
>> * Update API according to review comment by Greg Kroah-Hartman.
>> * Address review comments by Peter Zijlstra:
>>    - Avoid _Bool in composites
>>    - Fix typo
>>    - Use __mutex_owner() where applicable
>>    - Rely on built-in barriers for the main loop exit condition,
>>      struct ww_acquire_ctx::wounded. Update code comments.
>>    - Explain unlocked use of list_empty().
>> ---
>>   Documentation/locking/ww-mutex-design.txt |  54 ++++++++++++----
>>   drivers/dma-buf/reservation.c             |   2 +-
>>   drivers/gpu/drm/drm_modeset_lock.c        |   2 +-
>>   include/linux/ww_mutex.h                  |  19 ++++--
>>   kernel/locking/locktorture.c              |   2 +-
>>   kernel/locking/mutex.c                    | 103 +++++++++++++++++++++++++++---
>>   kernel/locking/test-ww_mutex.c            |   2 +-
>>   lib/locking-selftest.c                    |   2 +-
>>   8 files changed, 156 insertions(+), 30 deletions(-)
>>
>> diff --git a/Documentation/locking/ww-mutex-design.txt b/Documentation/locking/ww-mutex-design.txt
>> index 34c3a1b50b9a..b9597def9581 100644
>> --- a/Documentation/locking/ww-mutex-design.txt
>> +++ b/Documentation/locking/ww-mutex-design.txt
>> @@ -1,4 +1,4 @@
>> -Wait/Wound Deadlock-Proof Mutex Design
>> +Wound/Wait Deadlock-Proof Mutex Design
>>   ======================================
>>   
>>   Please read mutex-design.txt first, as it applies to wait/wound mutexes too.
>> @@ -32,10 +32,23 @@ the oldest task) wins, and the one with the higher reservation id (i.e. the
>>   younger task) unlocks all of the buffers that it has already locked, and then
>>   tries again.
>>   
>> -In the RDBMS literature this deadlock handling approach is called wait/wound:
>> -The older tasks waits until it can acquire the contended lock. The younger tasks
>> -needs to back off and drop all the locks it is currently holding, i.e. the
>> -younger task is wounded.
>> +In the RDBMS literature, a reservation ticket is associated with a transaction.
>> +and the deadlock handling approach is called Wait-Die. The name is based on
>> +the actions of a locking thread when it encounters an already locked mutex.
>> +If the transaction holding the lock is younger, the locking transaction waits.
>> +If the transaction holding the lock is older, the locking transaction backs off
>> +and dies. Hence Wait-Die.
>> +There is also another algorithm called Wound-Wait:
>> +If the transaction holding the lock is younger, the locking transaction
>> +preempts the transaction holding the lock, requiring it to back off. It
>> +Wounds the other transaction.
>> +If the transaction holding the lock is older, it waits for the other
>> +transaction. Hence Wound-Wait.
>> +The two algorithms are both fair in that a transaction will eventually succeed.
>> +However, the Wound-Wait algorithm is typically stated to generate fewer backoffs
>> +compared to Wait-Die, but is, on the other hand, associated with more work than
>> +Wait-Die when recovering from a backoff. Wound-Wait is also a preemptive
>> +algorithm which requires a reliable way to preempt another transaction.
>>   
>>   Concepts
>>   --------
>> @@ -47,10 +60,12 @@ Acquire context: To ensure eventual forward progress it is important the a task
>>   trying to acquire locks doesn't grab a new reservation id, but keeps the one it
>>   acquired when starting the lock acquisition. This ticket is stored in the
>>   acquire context. Furthermore the acquire context keeps track of debugging state
>> -to catch w/w mutex interface abuse.
>> +to catch w/w mutex interface abuse. An acquire context is representing a
>> +transaction.
>>   
>>   W/w class: In contrast to normal mutexes the lock class needs to be explicit for
>> -w/w mutexes, since it is required to initialize the acquire context.
>> +w/w mutexes, since it is required to initialize the acquire context. The lock
>> +class also specifies what algorithm to use, Wound-Wait or Wait-Die.
>>   
>>   Furthermore there are three different class of w/w lock acquire functions:
>>   
>> @@ -90,6 +105,12 @@ provided.
>>   Usage
>>   -----
>>   
>> +The algorithm (Wait-Die vs Wound-Wait) is chosen by using either
>> +DEFINE_WW_CLASS_WDIE() for Wait-Die or DEFINE_WW_CLASS() for Wound-Wait.
>> +As a rough rule of thumb, use Wound-Wait iff you typically expect the number
>> +of simultaneous competing transactions to be small, and the rollback cost can
>> +be substantial.
>> +
>>   Three different ways to acquire locks within the same w/w class. Common
>>   definitions for methods #1 and #2:
>>   
>> @@ -312,12 +333,23 @@ Design:
>>     We maintain the following invariants for the wait list:
>>     (1) Waiters with an acquire context are sorted by stamp order; waiters
>>         without an acquire context are interspersed in FIFO order.
>> -  (2) Among waiters with contexts, only the first one can have other locks
>> -      acquired already (ctx->acquired > 0). Note that this waiter may come
>> -      after other waiters without contexts in the list.
>> +  (2) For Wait-Die, among waiters with contexts, only the first one can have
>> +      other locks acquired already (ctx->acquired > 0). Note that this waiter
>> +      may come after other waiters without contexts in the list.
>> +
>> +  The Wound-Wait preemption is implemented with a lazy-preemption scheme:
>> +  The wounded status of the transaction is checked only when there is
>> +  contention for a new lock and hence a true chance of deadlock. In that
>> +  situation, if the transaction is wounded, it backs off, clears the
>> +  wounded status and retries. A great benefit of implementing preemption in
>> +  this way is that the wounded transaction can identify a contending lock to
>> +  wait for before restarting the transaction. Just blindly restarting the
>> +  transaction would likely make the transaction end up in a situation where
>> +  it would have to back off again.
>>   
>>     In general, not much contention is expected. The locks are typically used to
>> -  serialize access to resources for devices.
>> +  serialize access to resources for devices, and optimization focus should
>> +  therefore be directed towards the uncontended cases.
>>   
>>   Lockdep:
>>     Special care has been taken to warn for as many cases of api abuse
>> diff --git a/drivers/dma-buf/reservation.c b/drivers/dma-buf/reservation.c
>> index 314eb1071cce..b94a4bab2ecd 100644
>> --- a/drivers/dma-buf/reservation.c
>> +++ b/drivers/dma-buf/reservation.c
>> @@ -46,7 +46,7 @@
>>    * write-side updates.
>>    */
>>   
>> -DEFINE_WW_CLASS(reservation_ww_class);
>> +DEFINE_WW_CLASS_WDIE(reservation_ww_class);
>>   EXPORT_SYMBOL(reservation_ww_class);
>>   
>>   struct lock_class_key reservation_seqcount_class;
>> diff --git a/drivers/gpu/drm/drm_modeset_lock.c b/drivers/gpu/drm/drm_modeset_lock.c
>> index 8a5100685875..ff00a814f617 100644
>> --- a/drivers/gpu/drm/drm_modeset_lock.c
>> +++ b/drivers/gpu/drm/drm_modeset_lock.c
>> @@ -70,7 +70,7 @@
>>    * lists and lookup data structures.
>>    */
>>   
>> -static DEFINE_WW_CLASS(crtc_ww_class);
>> +static DEFINE_WW_CLASS_WDIE(crtc_ww_class);
>>   
>>   /**
>>    * drm_modeset_lock_all - take all modeset locks
>> diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
>> index 39fda195bf78..3880813b7db5 100644
>> --- a/include/linux/ww_mutex.h
>> +++ b/include/linux/ww_mutex.h
>> @@ -8,6 +8,8 @@
>>    *
>>    * Wound/wait implementation:
>>    *  Copyright (C) 2013 Canonical Ltd.
>> + * Choice of algorithm:
>> + *  Copyright (C) 2018 WMWare Inc.
>>    *
>>    * This file contains the main data structure and API definitions.
>>    */
>> @@ -23,15 +25,17 @@ struct ww_class {
>>   	struct lock_class_key mutex_key;
>>   	const char *acquire_name;
>>   	const char *mutex_name;
>> +	unsigned int is_wait_die;
>>   };
>>   
>>   struct ww_acquire_ctx {
>>   	struct task_struct *task;
>>   	unsigned long stamp;
>>   	unsigned acquired;
>> +	unsigned int wounded;
>> +	struct ww_class *ww_class;
>>   #ifdef CONFIG_DEBUG_MUTEXES
>>   	unsigned done_acquire;
>> -	struct ww_class *ww_class;
>>   	struct ww_mutex *contending_lock;
>>   #endif
>>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>> @@ -58,17 +62,21 @@ struct ww_mutex {
>>   # define __WW_CLASS_MUTEX_INITIALIZER(lockname, class)
>>   #endif
>>   
>> -#define __WW_CLASS_INITIALIZER(ww_class) \
>> +#define __WW_CLASS_INITIALIZER(ww_class, _is_wait_die)	    \
>>   		{ .stamp = ATOMIC_LONG_INIT(0) \
>>   		, .acquire_name = #ww_class "_acquire" \
>> -		, .mutex_name = #ww_class "_mutex" }
>> +		, .mutex_name = #ww_class "_mutex" \
>> +		, .is_wait_die = _is_wait_die }
>>   
>>   #define __WW_MUTEX_INITIALIZER(lockname, class) \
>>   		{ .base =  __MUTEX_INITIALIZER(lockname.base) \
>>   		__WW_CLASS_MUTEX_INITIALIZER(lockname, class) }
>>   
>>   #define DEFINE_WW_CLASS(classname) \
>> -	struct ww_class classname = __WW_CLASS_INITIALIZER(classname)
>> +	struct ww_class classname = __WW_CLASS_INITIALIZER(classname, 0)
>> +
>> +#define DEFINE_WW_CLASS_WDIE(classname)	\
>> +	struct ww_class classname = __WW_CLASS_INITIALIZER(classname, 1)
>>   
>>   #define DEFINE_WW_MUTEX(mutexname, ww_class) \
>>   	struct ww_mutex mutexname = __WW_MUTEX_INITIALIZER(mutexname, ww_class)
>> @@ -123,8 +131,9 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
>>   	ctx->task = current;
>>   	ctx->stamp = atomic_long_inc_return_relaxed(&ww_class->stamp);
>>   	ctx->acquired = 0;
>> -#ifdef CONFIG_DEBUG_MUTEXES
>>   	ctx->ww_class = ww_class;
>> +	ctx->wounded = false;
>> +#ifdef CONFIG_DEBUG_MUTEXES
>>   	ctx->done_acquire = 0;
>>   	ctx->contending_lock = NULL;
>>   #endif
>> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
>> index 6850ffd69125..e861c1bf0e1e 100644
>> --- a/kernel/locking/locktorture.c
>> +++ b/kernel/locking/locktorture.c
>> @@ -365,7 +365,7 @@ static struct lock_torture_ops mutex_lock_ops = {
>>   };
>>   
>>   #include <linux/ww_mutex.h>
>> -static DEFINE_WW_CLASS(torture_ww_class);
>> +static DEFINE_WW_CLASS_WDIE(torture_ww_class);
>>   static DEFINE_WW_MUTEX(torture_ww_mutex_0, &torture_ww_class);
>>   static DEFINE_WW_MUTEX(torture_ww_mutex_1, &torture_ww_class);
>>   static DEFINE_WW_MUTEX(torture_ww_mutex_2, &torture_ww_class);
>> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
>> index 2048359f33d2..ffa00b5aaf03 100644
>> --- a/kernel/locking/mutex.c
>> +++ b/kernel/locking/mutex.c
>> @@ -290,12 +290,49 @@ __ww_ctx_stamp_after(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
>>   	       (a->stamp != b->stamp || a > b);
>>   }
>>   
>> +/*
>> + * Wound the lock holder transaction if it's younger than the contending
>> + * transaction, and there is a possibility of a deadlock.
>> + * Also if the lock holder transaction isn't the current transaction,
>> + * make sure it's woken up in case it's sleeping on another ww mutex.
>> + */
>> +static bool __ww_mutex_wound(struct mutex *lock,
>> +			     struct ww_acquire_ctx *ww_ctx,
>> +			     struct ww_acquire_ctx *hold_ctx)
>> +{
>> +	struct task_struct *owner = __mutex_owner(lock);
>> +
>> +	lockdep_assert_held(&lock->wait_lock);
>> +
>> +	if (owner && hold_ctx && __ww_ctx_stamp_after(hold_ctx, ww_ctx) &&
>> +	    ww_ctx->acquired > 0) {
>> +		hold_ctx->wounded = 1;
>> +
>> +		/*
>> +		 * wake_up_process() paired with set_current_state() inserts
>> +		 * sufficient barriers to make sure @owner either sees it's
>> +		 * wounded or has a wakeup pending to re-read the wounded
>> +		 * state.
> IIUC, "sufficient barriers" = full memory barriers (here).  (You may
> want to be more specific.)

Thanks for reviewing!
OK. What about if someone relaxes that in the future? I mean, what we 
care about in this code is just that we have sufficient barriers for 
that statement to be true, regardless what type of barriers those really 
are?
>
>> +		 *
>> +		 * The value of hold_ctx->wounded in
>> +		 * __ww_mutex_lock_check_stamp();
> Missing parts/incomplete sentence?

Oops. I'll fix in next version.


>
>    Andrea
Thanks,
Thomas


