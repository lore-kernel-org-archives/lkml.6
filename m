Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeECF5z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 01:57:55 -0400
Received: from turvaposti2.pinus.fi ([195.10.156.33]:51736 "EHLO
        turvaposti.pinus.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751825AbeECF5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 01:57:53 -0400
Subject: Re: [PATCH v2 4/9] x86, memcpy_mcsafe: add write-protection-fault
 handling
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc: x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <152532351517.17218.3583455156840230837.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152532354268.17218.11923624861859552990.stgit@dwillia2-desk3.amr.corp.intel.com>
From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <69d19601-df56-687d-730e-d043b2cf7161@nextfour.com>
Date: Thu, 3 May 2018 08:29:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152532354268.17218.11923624861859552990.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.157.170.35]
X-ClientProxiedBy: HE1PR05CA0163.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::11) To VI1PR07MB3344.eurprd07.prod.outlook.com
 (2603:10a6:802:23::14)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR07MB3344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3344;3:dCulwqya5LuKmue4Af9QJGS5vFCvz2Og332aGW60+LNMy272Xna6cYHeN9b2pUssIXGM5ufIE0jUineZBp5AUnXRIN9aGh5bQGzSsZvbgwQ2jdpgkzQlwDDAsWMusuEWU6BnPi84L0eeMkBcH/dDQFW80O++0SNseiOp5biVkktH/CBgKCux7pnpg4eU0+9ldDXh5KcPtI9ux3tYglr+NptYxQCkOmI+L+R1Tp9yJg7Am+69yo9wTL+voH2oMqLC;25:sY+6ZsMenccQtGAgMlIkwjSrbhciqL5Fl+16Z672NzNVZYDuaNDylFBPvzoc8C3mOOBOMzOle1Az6Tk/gt1gWREwQ7RzvnuvoyCyNPXtObDfgts+/TQY0ZGmswO+y98dG3GGLSbqLvD13L/Pt65yM4DypVkovOQO6Z2MkvZHGCM8RiNx3Fkr2HAmoePEvS0Kci0Ux3FlE54VSqDfJ6XDKECL2x74qzvbZTLX+UyxWA67C+UelhcA7zhKTfI8dJNFQAl0OTNTju0sePDoT28cIFy7buOiJxUHjTJ7m9m0GskMsRDWuFJ4jv9fST3s485HXdvpGW7novTD/JUF+ih+kA==;31:Z4Fj6eoV4c1/f0tD7WUH/dJxZDmlKyvCJJidqCnt14cYUYo7r2ugTKYr0+JeP63aMvJvBq7wyvgX3GnsF5NL9ZxUltwnCeq69q6+IyRZliJQy6ic2V1ZY38s7pWIqadLqm7t1yEehPuWtldtA6dr936GvamWhqn/Y5xlbuzcLcPKXe80oO6UfjMV9/ot/5xDJKOJDjfj1eNzxf9biD7avPWTH+kL5Qz7SSStibr445s=
X-MS-TrafficTypeDiagnostic: VI1PR07MB3344:
X-Microsoft-Antispam-PRVS: <VI1PR07MB3344D760276B7C08CB13AB0083870@VI1PR07MB3344.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6041310)(20161123562045)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR07MB3344;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB3344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3344;4:58zuoUo/hO6IgHgytY8BDOLzsPDEdk6ALNLNnBH9d76MvQtJvsvY1bRht+arS3T8J3UiQlMP9QUZYhRO0PXo8IcdzH7iC4GJxm3ANG/4KHQ8rDsToyfdvc2HpwisZRE7rl03AL5zNzA/AuKZDnNPtTtwLjgt3j1351P4+W/ePcrBr8kOhwE8KbyUmibtM97ZR/XFnkQyiUKo46HMGj860Ww3JSCX0nAfLsBg3QPL/YUgz7l45ixJBL2xswKVli0B+khu0BQxDzJo4kyy9NU/FA==
X-Forefront-PRVS: 066153096A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39830400003)(366004)(376002)(346002)(396003)(39380400002)(189003)(199004)(50466002)(59450400001)(305945005)(68736007)(7416002)(23676004)(52116002)(66066001)(229853002)(47776003)(186003)(478600001)(7736002)(2486003)(65806001)(52146003)(105586002)(65956001)(97736004)(77096007)(2906002)(64126003)(486006)(65826007)(31686004)(11346002)(5660300001)(36756003)(2616005)(31696002)(956004)(54906003)(4326008)(6246003)(58126008)(25786009)(53936002)(8936002)(230700001)(3846002)(6486002)(26005)(6116002)(575784001)(86362001)(16526019)(81156014)(76176011)(106356001)(386003)(53546011)(6666003)(316002)(476003)(446003)(8676002)(16576012)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR07MB3344;H:[10.10.10.110];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA3TUIzMzQ0OzIzOlp4SDh5VmdFNWJ6RzhkYjVvQ2UvZmdXVzd4?=
 =?utf-8?B?bkcwNnlvUnJRSUlmd3FKazdCdlNpQ3hOTkI1ak9qODZNWURMV200U3FLNXd2?=
 =?utf-8?B?d2hQRGxuaGUvaHU1aXYvMXFzTERIclFSZ3VsRGZyV1hMWm5aNTB3YmpBWWxE?=
 =?utf-8?B?aktFd1lBRmwrdTRqY0R2RnNuQVZ0cXdTaEVoMUxJQkZDNE1VM3JVU2R5QU9a?=
 =?utf-8?B?aVpjSGQ4UWliZGVyZGlnbG1ZdnB4eWlGMERNcTJiTVVpRE5NK2FYY1JoOWFo?=
 =?utf-8?B?WEtsS1hlODU0UTZTNGhlbXplRFd1R0F5ckhwVzlsTlM5Ykl3SVc0OHJsVmNh?=
 =?utf-8?B?UXRrcVlyNzhoUkFiUnJaNGZpTnNNWGhLOFg0VnlWYnkzTDhtcGNCaUpqNHBv?=
 =?utf-8?B?dnIrUmV2ODIvRzBNSTFubEIwNjhDOXNETWNJRm5KNkw2ZlVNbmYrT2R5aVNN?=
 =?utf-8?B?YURFMFFLT1hjdzgxR1krMkpDYmRiQVdYTTc5WnZzQldBVTFYekFwSEJtaWlw?=
 =?utf-8?B?aXBNbjIvYVRFNmtpaGNienVCZDRxSm93VEVyd2JPUUdYNlVmZDg1ZU9CaHZJ?=
 =?utf-8?B?eml0UUFzVVhNaVdmOWVRaEtIMVYwVzg0R04yQm1WbnhlTGMrOHYxU0JmQTd3?=
 =?utf-8?B?L3ZwSnR0bDlhQTdpdU5NSTJRc0xGZFRCd25uS05vWm1CM1BJZ1hMdDV6ZDRY?=
 =?utf-8?B?V0ZHbHFwNWNUQzI3S043SzZHOFR6WnpDRHhRaUFGc1hCV205Rm9ub3lQZzB0?=
 =?utf-8?B?ekFMNWJxQk5QT3dPYnROSko4WEtaUWtVaVRHb3BWK2FqWjlxekkxU3ozUXpL?=
 =?utf-8?B?V3RMMlpoakp1bGlSVlZ0cGRHTWJES0lsMGgxejJ1cEoyVkZmUXNZRWhIbkFR?=
 =?utf-8?B?T2FYa2pNazU5MzN0amwwbVJZWmsvb0F0aGVzRFI2T0JMYmg3bFJ3VW1wRlUr?=
 =?utf-8?B?aVNpTURuOERjQVJieUU5dkpMTkw4OUNmNUpkSm9yNFNSSWQ1ZXkxZlNoamtH?=
 =?utf-8?B?bUw0YjFHTnhqMUl4QUR2V0pxRFZrS0ZuT0hITE9yMVBCWWFyUUlwVTBWamV4?=
 =?utf-8?B?NzliajVTbzV0YjVmS2lkUGVCUSt6MWpkYUxzVko3Tzh0THRPL2RVMDhwQ0x6?=
 =?utf-8?B?d3c2SjV2N1NIdFU3TUFkTVowcnJMZlVXRS9MbDRLejFrQ0ZTUjJPVHhFQm9p?=
 =?utf-8?B?VmZ6aHhKME1DN2w5QnlOa1ZBVjEvdjJheVhKMUMwTHhCTkpmSGcvN0ZmSHJZ?=
 =?utf-8?B?VjU4UWJiNUxDNFBsMGtRYm82OXI1dXZEVnhLeTlUclFYZUEzNktwL3doaHBu?=
 =?utf-8?B?ZlEvRmVDWVRTK08xa1h0MU10T0dqQkxUeGZpVlk4SlNaMm5wT3lqeFNNMi8r?=
 =?utf-8?B?UG11REtoRklNTG8wRzA1eXRvSXlvNVY4K1JSdUNnNzJoTVl2M2xRNFB1MEx5?=
 =?utf-8?B?Z3VzRi8yNXBrOG92MVpYUUtSYzAzSlo3akU4TDMzVHZkcHducHlSZWZHVDU5?=
 =?utf-8?B?eDc4aHljcjZBOGc1M2VjekFjdlVid1NXUlpBVG5yWGJNamNMckdxNDVzOE01?=
 =?utf-8?B?N0lYY3ZNbDlSWU91bU5JZlI5bERwbi82SzFXSUtYRHBhSStoaVJFVjZoZEdF?=
 =?utf-8?B?Y0NldW1IdHVubVRNaVNMNkV6dHUxWEFNVmNsNytNcnNFRll3Q1ZLMDFES0dj?=
 =?utf-8?B?S3NuU3N4bGpFTmFhY3JLV0dtVjVKblRoUjB1cHhPM0w3L0QzZklBbm9VcDND?=
 =?utf-8?B?T2NnbFFWWkx2QUJzaSsxWEs2MUdBbENIQlhxWHRJQ3FCV1R1U1pqRWdSVGVm?=
 =?utf-8?B?RFZ5ZEw4eFR4MktVNzRJWjVxajNlengydmdBNG5jUmpMOXVENDNpYXpmcU9r?=
 =?utf-8?B?bUQvTUVDS3FKUlprUUhhUzRhckJNaCt0UERqNUtEL1FYUkFvNnBOd2NINlI3?=
 =?utf-8?B?SnB1VUQ1d25sR3BhMUVNQU9NNkZzTmVjQ0x3MWlwZlhaTUk0WXFxYnJ1OVMr?=
 =?utf-8?B?KzE2ZlNDTWJtN2NZcGJRZjN4UTNqMnJuZHVuZz09?=
X-Microsoft-Antispam-Message-Info: IG5DLaExJx/tZS9rApFzVHVCJZZKPzGaPIjtna7sSe08eXVTrHEePvDYt9GMvHh14zbTqDCNrUS2OoKZPaBOaRPQDDJeXamOwfvoBa2fRPzEW1hnTwNEm1sE1XCDBrgyMdYBuVFss9v1pDJU+QCWRHMEM+1fyubBvjsdayC0ifISO+asShTqmzTcpKxUOWQL
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3344;6:0MTE3CSUlyPlIK60VUz3r0yzppigm1NRj8R2DqKHZrojJdgRsCMHN/BghY8FtQozEEtzqrkEgy6HTs7nLkYQKRctxyy/IBwfJbkSpXSI+5sKtI9ifqiJ0Dr8nmsFQfmyBi9JfFxKqDEpWvzrQ8vUqhpehK3aXpoY6sRSZK8CN2a9xaQmhmsBEUbe4gXuHfGg935J2tuuI3vdR0NsuwXGFj+G8AahJStPINJnfdJ6APqqg4EUWJCFZ/D4mWHsCLwt49VGtQZGOaJqVbjQDPda3Gaw6Xtxeotw4SNrpj1MhfxRZgrDecjU/AHzlv3VJQST3Af6Kx95dhAAkuWx80ZBUlRBjSiPuvq4X7r9pPUJtp6XPBUjbujmEJEFrLkcGiztsLrvDC/pXfGKortGEN6PeQVcSY3nQSWR1jllJtp898U20I5YBxavtz2u4sxKwfN4HZ8EqkuOPeh8F3vyPXdY0A==;5:YQfPeS1ofasThganDxaxHAaeY4Zr2QdobERTcJ+1RBZUgATlnqB1OFmpyRcDmylJD2gfVgFG7Td6yEqKLnYFh+M6GCrIYGsEdJkjUCqGYAaJS6/TWnS2VmGiZxJukWZb7HYYQO2vKro4jwUOMYGJ3m4gdGIu1GL6wq7T3SCNuig=;24:XmRGyuxfajXC2P94SCTzcDt8Z8IinmFsNDWCpr+xK4CFjxeXiqNlk9zt88tt6GJR2eIPRaU5WiNMQBYTAhb6hB5vWiYavU8f6Ft+Y96qE28=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3344;7:w02+LuNIgClOFgFRYFiuriKaBBzklxuL/rgEpwGz4bXNCjlh/evarP/+cKf0YBsqFdG7XKIdZbNGWj9+2Lh92ZGAbrhc9objnGYHnbt3txOjnygWE5tJsMBnwAisrx0dYTX1Rul8ukwXe8LL3FjyoI3npIXuG1JT7cLWboEfArpSjoayeR5n1EcCH8KgfEUmhmF9gQ+QjdbNqYubY1mjqX5ssGU23G/eVfwqUXMDNZL+3Of5TUVZmp4aBoRgbNjJ
X-MS-Office365-Filtering-Correlation-Id: f2384a6a-c73c-4737-fa07-08d5b0b6e44b
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2018 05:29:49.3201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2384a6a-c73c-4737-fa07-08d5b0b6e44b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB3344
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805030050
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2018 07:59 AM, Dan Williams wrote:
> In preparation for using memcpy_mcsafe() to handle user copies it needs
> to be to handle write-protection faults while writing user pages. Add
> MMU-fault handlers alongside the machine-check exception handlers.
> 
> Note that the machine check fault exception handling makes assumptions
> about source buffer alignment and poison alignment. In the write fault
> case, given the destination buffer is arbitrarily aligned, it needs a
> separate / additional fault handling approach. The mcsafe_handle_tail()
> helper is reused. The @limit argument is set to @len since there is no
> safety concern about retriggering an MMU fault, and this simplifies the
> assembly.
> 

> diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
> index 75d3776123cc..9787f5ee0cf9 100644
> --- a/arch/x86/lib/usercopy_64.c
> +++ b/arch/x86/lib/usercopy_64.c
> @@ -75,6 +75,23 @@ copy_user_handle_tail(char *to, char *from, unsigned len)
>  	return len;
>  }
>  
> +/*
> + * Similar to copy_user_handle_tail, probe for the write fault point,
> + * but reuse __memcpy_mcsafe in case a new read error is encountered.
> + * clac() is handled in _copy_to_iter_mcsafe().
> + */
> +__visible unsigned long
> +mcsafe_handle_tail(char *to, char *from, unsigned len)
> +{
> +	for (; len; --len, to++) {
> +		unsigned long rem = memcpy_mcsafe(to, from, 1);
> +


Hmm why not 
	for (; len; --len, from++, to++)



> +		if (rem)
> +			break;
> +	}
> +	return len;
> +}


--Mika
