Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755218AbeDWMnZ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:43:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754857AbeDWMnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:43:22 -0400
Subject: Re: [RESEND PATCH v1 2/2] trace: events: block: Add tag in block
 trace events
To: "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhad.com" <mingo@redhad.com>,
        "Bart.VanAssche@sandisk.com" <Bart.VanAssche@sandisk.com>,
        "rajatja@google.com" <rajatja@google.com>
References: <64d6073b28b140cda3e5870a54e0a7bc@SIWEX5A.sing.micron.com>
From: Steffen Maier <maier@linux.ibm.com>
Date: Mon, 23 Apr 2018 14:43:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <64d6073b28b140cda3e5870a54e0a7bc@SIWEX5A.sing.micron.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18042312-0008-0000-0000-000004EE461B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042312-0009-0000-0000-00001E826921
Message-Id: <f28ab517-9172-e585-718c-8a54adbfc3bc@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230132
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/16/2018 04:33 PM, Bean Huo (beanhuo) wrote:
> Print the request tag along with other information in block trace events
> when tracing request , and unplug type (Sync / Async).
> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>   include/trace/events/block.h | 36 +++++++++++++++++++++++++-----------
>   1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index 81b43f5..f8c0b9e 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h

> @@ -478,15 +486,18 @@ DECLARE_EVENT_CLASS(block_unplug,
> 
>   	TP_STRUCT__entry(
>   		__field( int,		nr_rq			)
> +		__field( bool,		explicit		)
>   		__array( char,		comm,	TASK_COMM_LEN	)
>   	),
> 
>   	TP_fast_assign(
>   		__entry->nr_rq = depth;
> +		__entry->explicit = explicit;
>   		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
>   	),
> 
> -	TP_printk("[%s] %d", __entry->comm, __entry->nr_rq)
> +	TP_printk("[%s] %d %s", __entry->comm, __entry->nr_rq,
> +		   __entry->explicit ? "Sync" : "Async")
>   );
> 
>   /**

This entire hunk does not seem related to this patch description.
Also, I'm not sure trace-cmd and perf et al. could format it accordingly.
See also my patch for this same functionality:
https://www.spinics.net/lists/linux-block/msg24691.html
("[PATCH v2 1/2] tracing/events: block: track and print if unplug was 
explicit or schedule")



-- 
Mit freundlichen Grüßen / Kind regards
Steffen Maier

Linux on z Systems Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
