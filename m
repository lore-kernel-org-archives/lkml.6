Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1819EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F90208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="mRrLaF5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F90208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936077AbeFNMJW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:09:22 -0400
Received: from mail-eopbgr730072.outbound.protection.outlook.com ([40.107.73.72]:7072
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754967AbeFNMJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YXzBDk91JIzAN1N8F9rb+rI/mJutHBwMotwFrlEQUs=;
 b=mRrLaF5MWOOOJ2YWugZ72JhXLldDBqVm+BLbTZ6/TeC3mvKgOKdKtQgg4gauNSB7foFrGH/4C+4INwCY0ZP+/nxAK5OxVheL5di4f24TDdNZeykVEJpy63D2jIR37nye0BSe7NVOLk6HInbYa4O1KbHJz6MsbnG/xK8EtePdZxI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
Received: from localhost.localdomain (155.4.205.56) by
 SN6PR05MB4589.namprd05.prod.outlook.com (2603:10b6:805:38::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.12; Thu, 14 Jun 2018 12:09:12 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
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
 <b84a5ef9-6cd1-7dc9-a51d-cb195cdea83c@vmware.com>
 <20180614114944.GA18651@andrea>
Message-ID: <9c2bdfa1-745a-e618-5429-4305a095847f@vmware.com>
Date:   Thu, 14 Jun 2018 14:08:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180614114944.GA18651@andrea>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR05CA0137.eurprd05.prod.outlook.com
 (2603:10a6:7:28::24) To SN6PR05MB4589.namprd05.prod.outlook.com
 (2603:10b6:805:38::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9ff8ab5-1e5c-4700-ca55-08d5d1efa692
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR05MB4589;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;3:QWRaY+xWLj8TR47W5GkmREvuYLydo80LSfsxI15AtE1hkE1Wmu2McS99CTrFPIrsZ44BvRRvJC11FuSli5vR5jG8Gmmdmc1n/AUAycNmznJ+ixXb/A3XUxKpEpH6uShGaQGUpqepTBQ4+6CHn+JcLM+0odcBB7UafnSsi+vuk0kCGOgFLZfQFnjP7CN4EYnm2yfsDy/OhhS6pDEKqsUndsOIbhCnkRTm4tLnLqpqBImhHUtTsAGdEaAB7hveizzy;25:W0ITMbvhJCR7PVy3EOrUx3gjYPI0zl8EJqY1O2XdAZ5WS0znCLcwkKzgkgAQdr+X1VR9Xpi8O8utb08UYfsS6RiWyJfV9qJhUC14oS6Hn1coSnuVQ2IIknAu7Eazm33JS461lbZBoaQRsFl1GL0/u+6bgfYngOM6Yyp1UIVkaQXo4skHCM/GiSPKBB8tOnYppNNHCGV+6lDw8k0/9hzQpjqz8mKHtw73aukV0WUL1Kwxa4+z07UnQ7jCuKL7ZgX2/uoZL9DzKdImJSWkGtT89bCIEJ4WQRJBcuzvSi3VT5wmOfOIInKA88CV4fFqCzgCotIXuUqDwQsXFdAkBOdJew==;31:OexXrVThOrTAJIfV+psiCGC0Fl1mzsyg/wCwl182gH9bjuUQqFHxTb54V/h0nHyCs8qON4QLuC+ZTcTrekvxnyLqOjbrYdMCMTO92XbD9Ddf4klK+gFAWVnS9uDYaYE0XxqyCAkdjH1HWgUb0Q8O/V5DkMPgtxFIOxoVIRSvc9WMSCIHBuSbsSypqe5FM/G5O5GnksGl7u74gQNZYFZZ6FKP6eFXailR3f3ao0c2xH8=
X-MS-TrafficTypeDiagnostic: SN6PR05MB4589:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;20:2lw4n4t1XWw3+50GK8Ug8+UxIwznMqKhhBnzTpbWIsFsg/JWOf3/Qnq/zPM/kMlrBoyTPGchK0NrjoIXleRGUETZIArQQaN8IsOhix8gieqbdq+VFIRgLUDDjnJ6XjDv7ygN960OMhDZAEq3VbX+YY7XVjT1Pkl6rGLh5jnAiNGxsf1u/OGzuWMVlEt4pQ7OTPTsVH+V64Im0hQGas18EiEe+gsxi4Q3IXgi34geWeOVIr+331DmdFTZ7WFLg3PQJ0Z9TF8K4wd4k6snS5KQq/rrNxvFmw00u2Gq+qWAOwLhA83q9Zw+rJCx4AiZ7syPV5rvbmQxoijvTauSvL3/bhH4k4nmuE2bgZhJN/0Th8UjXFv5WvUuqtZ0CAThutxzmT4HMnXi/1/sUAsKKeP+Z84yVv1sMzJ+L3kG0el01gBg8TUe2cXNKsMeyPgIitUSdXzyKrsAc99XyOa6+pUCFyK101snkigzMzPdc2Ma6Efa86zNqv7IdeJzs5ocYblc;4:RzFEoCY0WgNLLFo7x7Y2AX8Xj4i20ca1FvXwrVrORZadCOivPV4n6CUXFsqTagMt2Ef745pL2+mtnfgxfVCy7evWkk6fhMmOQ0xfaqz/gR+Y/1/SQOM4fxTxv4NSpXU76nxuArXUomt3fkUp0reE/CmP3WFSsgrgr9WL3NrAfLEBNBPeZ+xZ2gBBnEtnJ0GlDVj2+JJXAQqcccglj0pDI7NZ0G/SpNR3bZqNK0waAAxqwwnrNWSslgjzepPAqGUHCMIDXWO1L+5mTYbERnfrjg==
X-Microsoft-Antispam-PRVS: <SN6PR05MB4589B7D8F763AF4C3DF8D3E9A17D0@SN6PR05MB4589.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN6PR05MB4589;BCL:0;PCL:0;RULEID:;SRVR:SN6PR05MB4589;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(39860400002)(376002)(396003)(366004)(346002)(189003)(199004)(53546011)(76176011)(31686004)(93886005)(97736004)(4326008)(65826007)(26005)(53936002)(386003)(186003)(105586002)(6506007)(68736007)(5660300001)(106356001)(2906002)(7416002)(6246003)(230700001)(16526019)(25786009)(47776003)(66066001)(8936002)(3846002)(65956001)(65806001)(6116002)(59450400001)(64126003)(81166006)(229853002)(446003)(11346002)(6916009)(486006)(305945005)(6666003)(36756003)(2616005)(8676002)(7736002)(6512007)(23676004)(58126008)(476003)(6486002)(86362001)(956004)(478600001)(31696002)(50466002)(316002)(52116002)(52146003)(54906003)(2486003)(67846002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4589;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjA1TUI0NTg5OzIzOmF6NTZUeHhkWlhoeUUvZXRYWnBiT2FNRjgw?=
 =?utf-8?B?NThKSis3T2FjMHJLTkcrRHFKY2FxakpXSFhIVXNhbjBJcHorTTliejNCRFFV?=
 =?utf-8?B?R3F3eS9qNmZya0ZyNTM3Q3ZqL0dhR1lsVzBGRFp0L05JZ1dNNit6N1lUYUt5?=
 =?utf-8?B?eVpScWlubXNvUTcyZjFSZHRpK0txYlN6UmV3VHNObHZiVkVmcUtIZURCMWRB?=
 =?utf-8?B?dVZ4S2x5RlM3M2ZORDNKMFNlOTRkaWx4Y1R1cDR0cm9TTGpuc09pZzFmSzI2?=
 =?utf-8?B?L1NhRUdOdVF2RkUwUXljVXZ6SGN0RkhRblBDd1RlTS9oQ3NucEhuS3lxWC9v?=
 =?utf-8?B?QWtqSmh6U1BvckxTMzBDWXpNS2xLQ3ppT1U1Q2hOS1dFK0U2SndydHVGWkk0?=
 =?utf-8?B?SmJTWTZJS0tsWFVWTzZHQ0h6Z2xNaDRLZVpmcGp2QmtvRkcxRHZtL21CMnJO?=
 =?utf-8?B?cXNFbHdHempkcnByUnV5dGNIUVFCc0pCMVkrcVdsbTBHY09rMVdZMzdXb3Zq?=
 =?utf-8?B?VitVSEtjbVp0eEgwcVY0Y0FYWWZmZmdFSC95MTJBRGxjbzNjR2hqV0hkT3Rk?=
 =?utf-8?B?Z1VBRjN2QXdQL09lNUR2MFdZa3pOUERhMnlsUjNncHJqR0dsN2FPalFrR2Y1?=
 =?utf-8?B?MVNPSTNVQVRlWi9NMjVDWkxUZ2Q1TE9JSjJkc29QZVErOGloVE8xUUhHdi9r?=
 =?utf-8?B?QWl5d1RhRVpnYnU2TWU4UmFkbGUwc3NqMGgyVGNkRXEyYzZFNEFoVGdVTjNr?=
 =?utf-8?B?V1RLVC90dnhqeTQwWkNBTGltZ0ZCWFUxUjlQcFkxU0lhUU5oajhFUjU4UGoy?=
 =?utf-8?B?V3Q0ZnpEUGIrYlVVb3dRdW8rT1hPMU1TaGJuMzJ3eG1xYzM5THdzckFXeFpw?=
 =?utf-8?B?Q21WSU5TVEZwWlpXVk5yWmg4Y0pVaUFKTDJ1SnE1Tnhic2tWbHdER2phL0tl?=
 =?utf-8?B?bktsc3NFUFJEUzdERHgyeXFWRXRFTE1pVG0vTmF0QWkxaVBVL1B5dENlOGl6?=
 =?utf-8?B?L2NLL3ZwVm1zVmZPRmFlSFFyQnVyTHplN2kzMEsyRGJPSitrUVM1RWdRRllk?=
 =?utf-8?B?dVBOUldqYVp3Wi9jV3RVRENBcERTcDdXcHRsVFUxMU50Sm9melAzeGxTMUpW?=
 =?utf-8?B?RUk5N2JRWVpRbkhURWFWWk1hL0JLRUQvMU9BSlR3T3VtZTlxc1Irbk9CSlo3?=
 =?utf-8?B?Y0J4dHg5ZC9kMi94QjZINGk2OTFKSWg2dG45QkcrQWlydUhBS1dWMjAzbEFt?=
 =?utf-8?B?MVlacTlBU2FZZTJHR1RlR1Zud2ZCQlhQdGVhZ3JJdFJtTUlKUWdsQk1TMVNs?=
 =?utf-8?B?RzhSLytSSDEwTFlRZ1hObXBSWlNrdnNXSjZFdzVHbEVyVlVQbnlkUXhBSHky?=
 =?utf-8?B?K3JVczVCdUV2OHppc0NpbWFMYUVOU2FkZlF0Q3N3b1NBbE8wRFZlcGpDL1VL?=
 =?utf-8?B?T1JHeG1QaFVnZnZ4OFlsRlJ6N0hGdkw0SVhVUnVqOHluOTNveW8yTjYwTHM0?=
 =?utf-8?B?ekpaS2QwZ0c1UTVlQ2RKcmo0aGFQZHVVVlBtL1pZeWl5YzVnREFZQkJIbEJo?=
 =?utf-8?B?ZC9ocXJnRWRUVVFSMld4dURPRDg0S3Y0TnFWZlIwV3Qvblphcno2NWlrUUpi?=
 =?utf-8?B?bkNGRjJpWlJGckd0Q3VBaWFsbE1oWnBiVUJ5Y2xJMWw1R2tnT2pPZ3NsRjdj?=
 =?utf-8?B?Skh6ZkQyTTZBUWpuMlhaZVVNTGFFY3BTRzZmV1BkWUNrazA1RUlPWVMvKzJI?=
 =?utf-8?B?cUlSMlVBS1RucnNISUJsNnRNNEJKMXZ3TFQ4NDU1UkhjWCs4d2R5QjZXcVFX?=
 =?utf-8?B?VytJUWJ1Q3FLYVFQK0QvRXdkVjdUWGJSWk8vQ2dGZ2pCZ0ZuQUtwcDFRbWwy?=
 =?utf-8?B?ekxUajQ4V0E4V3JsY1BWb2ZWQncwMmFqdzdQUGJyTEpERjBPSko1Vk9JSzdF?=
 =?utf-8?B?MVVvemthcjZNejdyZjVDM1prRWF4VTNpSnpLemw1Ym9mYXdrOU8zeFdQeE43?=
 =?utf-8?B?TDFSV2JCZjh1YUM2RDVpby9qanlEWkJUcmROREVTL3I0YXI4Y1Fjd2J0SlI5?=
 =?utf-8?Q?J2pKHi1aw8TBABwT00VktLt+1?=
X-Microsoft-Antispam-Message-Info: S5+srasDce8LZiAp0JAeIXTGgeRjYLXymzKU9UkQf2sD/YSKm8B6gIcpOhaRsFLa7daC+zYB0kJtrcp3CHJTrPMr1rYAdwFf1k5q7kYv0qNe8kR9gby/fF4j4fJP8TXrMOegtMnmWbFngcfEjZ1/mmiiwrBxZrvGG2B7uTEIcMhX8O2DWCpcOsTXUHp1pRPr
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;6:cgXg/m2niyOgSTh/UL9D44xWfLPdJZ3kcI5YUAgBMFFs1yooKddsLlQWoFD4PNqBB9XiOcrdCM7Z4Y2mESRrA2heZWDTthMiEax9nNbTFc0WIuzNGULBuwLbkdxHlaOtFgMZksCvVsBINzKVJU7h/+kbYVmnWlZbw21sI9CbGByw+DzFJkvWUsh9RupcVSvl7wQcFJesUeei53P8qfpd5x9dZ2TL6p5Dk5PErn/XJNyuuAsnVsPtwDQea6vjn+R+Nz0jpvl2p4M6FCBK1CO1v4d3CyPmoVCz3puznLtLpD0w5RGoMFHUOfWl9Gqq9+B7i1jtQc0B4D808D1P3WT1ZcK6TSho63Gy3zFL+BtGB+CXHhTeIilVQ66L44jkiitZoy5Mj3h6Bl6KXk3Jagll4KGiZf38dmP2371j9cryoQ+xzVHO2glynk2YAdDcbbjyAHmuMlkRE1rbgSuztvx3Xw==;5:2BZJjECh/ZqyKf8JLxocDB2YGjAm3sMSXgSCGPLg8y1zu8c0ppc9RES+P85iqSVSpttUjIoXPLRUjjflLYHX+YxU3P0m2YF5zGZJ6pj6QSbazAeQw/A1MLWjWo1iH0vgOYB8GYWw/eFO9qU2weCG4necJqYE2PX/q/zU5rbTV0E=;24:E8IJlTMHjRGZKuZiMywOohbOoOvagqPNVw+u8MYUfMO1XEGSLjpCEtv9NUZzUuEUOsotJCe20sqxeOGlYYO6rFh9tyQFbclQ2P1gLghtNbA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR05MB4589;7:bTFvq7KzV11L30y8+beQ+onr1vZeafXZMBbdz1K6sv3i71iQpcYsUsLt/xRykq3sEwcFMjgU2v+pbrosM1Ovj4akydqWSDg0qFlUjvZH7cGQEEDpYnIK1p9WhcqjnvpM7+m2wSvGGRBhOws+ZG+JRIREiM1RFlusv0n+4nJwLqv/LuDv32wMXUhrS6qhweDBRscSh11eqaObTOpLYCPdptFHm+bCa0BNxrSkOdk3T4QTmWupL7WLSn8pjaGxOdBp;20:OPyiZIhsPX4EG8u5koa7nrv56kHd2iJBwvfJucr2tQRa8y3rzU6vzPwtVFmqttrgRcQE8e871e6cRd4pvlts4oQ7F2VDSa0gB942KqGDAoztDnOHWTR2LMMu5uSu017J5pPA31EtKSgf1xg9SF8bV8qT0upAD+WRNvShC+Y0sbo=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 12:09:12.3570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ff8ab5-1e5c-4700-ca55-08d5d1efa692
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending hopefully better formatted..


On 06/14/2018 01:49 PM, Andrea Parri wrote:
> [...]
>
>>>> +		/*
>>>> +		 * wake_up_process() paired with set_current_state() inserts
>>>> +		 * sufficient barriers to make sure @owner either sees it's
>>>> +		 * wounded or has a wakeup pending to re-read the wounded
>>>> +		 * state.
>>> IIUC, "sufficient barriers" = full memory barriers (here).  (You may
>>> want to be more specific.)
>> Thanks for reviewing!
>> OK. What about if someone relaxes that in the future?
> This is actually one of my main concerns ;-)  as, IIUC, those barriers are
> not only sufficient but also necessary: anything "less than a full barrier"
> (in either wake_up_process() or set_current_state()) would _not_ guarantee
> the "condition" above unless I'm misunderstanding it.
>
> But am I misunderstanding it?  Which barriers/guarantee do you _need_ from
> the above mentioned pairing? (hence my comment...)
>
>    Andrea

No you are probably not misunderstanding me at all. My comment 
originated from the reading of the kerneldoc of set_current_state()

/*
* set_current_state() includes a barrier so that the write of current->state
* is correctly serialised wrt the caller's subsequent test of whether to
* actually sleep:
*
* for (;;) {
* set_current_state(TASK_UNINTERRUPTIBLE);
* if (!need_sleep)
* break;
*
* schedule();
* }
* __set_current_state(TASK_RUNNING);
*
* If the caller does not need such serialisation (because, for instance, the
* condition test and condition change and wakeup are under the same 
lock) then
* use __set_current_state().
*
* The above is typically ordered against the wakeup, which does:
*
* need_sleep = false;
* wake_up_state(p, TASK_UNINTERRUPTIBLE);
*
* Where wake_up_state() (and all other wakeup primitives) imply enough
* barriers to order the store of the variable against wakeup.
---
*/

And with ctx->wounded := !need_sleep this exactly matches what's 
happening in my code. So what I was trying to say in the comment was 
that this above contract is sufficient to guarantee the "condition" 
above, whitout me actually knowing exactly what barriers are required. 
Thanks, Thomas

