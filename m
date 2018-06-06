Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B787E607CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeFFOxa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:53:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751957AbeFFOx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:53:29 -0400
Subject: Re: [PATCH 42/46] perf script powerpc: Python script for hypervisor
 call statistics
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20180605175030.32549-1-acme@kernel.org>
 <20180605175030.32549-43-acme@kernel.org>
From: Paul Clarke <pc@us.ibm.com>
Date: Wed, 6 Jun 2018 09:53:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180605175030.32549-43-acme@kernel.org>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18060614-0072-0000-0000-000003694007
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009139; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01043027; UDB=6.00534142; IPR=6.00822157;
 MB=3.00021491; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-06 14:53:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060614-0073-0000-0000-00004844209A
Message-Id: <c58ba06a-2a1b-a981-b9a5-27708ea2479a@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-06_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806060170
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 12:50 PM, Arnaldo Carvalho de Melo wrote:
> From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> Add python script to show hypervisor call statistics. Ex,
> 
>   # perf record -a -e "{powerpc:hcall_entry,powerpc:hcall_exit}"
>   # perf script -s scripts/python/powerpc-hcalls.py
>     hcall                            count   min(ns)   max(ns)   avg(ns)
>     --------------------------------------------------------------------
>     H_RANDOM                            82       838      1164       904
>     H_PUT_TCE                           47      1078      5928      2003
>     H_EOI                              266      1336      3546      1654
>     H_ENTER                             28      1646      4038      1952
>     H_PUT_TCE_INDIRECT                 230      2166     18168      6109
>     H_IPI                              238      1072      3232      1688
>     H_SEND_LOGICAL_LAN                  42      5488     21366      7694
>     H_STUFF_TCE                        294       986      6210      3591
>     H_XIRR                             266      2286      6990      3783
>     H_PROTECT                           10      2196      3556      2555
>     H_VIO_SIGNAL                       294      1028      2784      1311
>     H_ADD_LOGICAL_LAN_BUFFER            53      1978      3450      2600
>     H_SEND_CRQ                          77      1762      7240      2447

This translation from HCALL code to mnemonic is more generally useful.  Is there a good way to make the "hcall_table_lookup" function more generally available, like "syscall_name" in scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py ?  It's even simpler than the syscall ID-to-name mapping, because the HCALL codes are constant, unlike syscall IDs which vary between arches.

> diff --git a/tools/perf/scripts/python/powerpc-hcalls.py b/tools/perf/scripts/python/powerpc-hcalls.py
> new file mode 100644
> index 000000000000..00e0e7476e55
> --- /dev/null
> +++ b/tools/perf/scripts/python/powerpc-hcalls.py
> @@ -0,0 +1,200 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2018 Ravi Bangoria, IBM Corporation
> +#
> +# Hypervisor call statisics
> +
> +import os
> +import sys
> +
> +sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> +	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> +
> +from perf_trace_context import *
> +from Core import *
> +from Util import *
> +
> +# output: {
> +#	opcode: {
> +#		'min': minimum time nsec
> +#		'max': maximum time nsec
> +#		'time': average time nsec
> +#		'cnt': counter
> +#	} ...
> +# }
> +output = {}
> +
> +# d_enter: {
> +#	cpu: {
> +#		opcode: nsec
> +#	} ...
> +# }
> +d_enter = {}
> +
> +hcall_table = {
> +	4: 'H_REMOVE',
> +	8: 'H_ENTER',
> +	12: 'H_READ',
> +	16: 'H_CLEAR_MOD',
> +	20: 'H_CLEAR_REF',
> +	24: 'H_PROTECT',
> +	28: 'H_GET_TCE',
> +	32: 'H_PUT_TCE',
> +	36: 'H_SET_SPRG0',
> +	40: 'H_SET_DABR',
> +	44: 'H_PAGE_INIT',
> +	48: 'H_SET_ASR',
> +	52: 'H_ASR_ON',
> +	56: 'H_ASR_OFF',
> +	60: 'H_LOGICAL_CI_LOAD',
> +	64: 'H_LOGICAL_CI_STORE',
> +	68: 'H_LOGICAL_CACHE_LOAD',
> +	72: 'H_LOGICAL_CACHE_STORE',
> +	76: 'H_LOGICAL_ICBI',
> +	80: 'H_LOGICAL_DCBF',
> +	84: 'H_GET_TERM_CHAR',
> +	88: 'H_PUT_TERM_CHAR',
> +	92: 'H_REAL_TO_LOGICAL',
> +	96: 'H_HYPERVISOR_DATA',
> +	100: 'H_EOI',
> +	104: 'H_CPPR',
> +	108: 'H_IPI',
> +	112: 'H_IPOLL',
> +	116: 'H_XIRR',
> +	120: 'H_MIGRATE_DMA',
> +	124: 'H_PERFMON',
> +	220: 'H_REGISTER_VPA',
> +	224: 'H_CEDE',
> +	228: 'H_CONFER',
> +	232: 'H_PROD',
> +	236: 'H_GET_PPP',
> +	240: 'H_SET_PPP',
> +	244: 'H_PURR',
> +	248: 'H_PIC',
> +	252: 'H_REG_CRQ',
> +	256: 'H_FREE_CRQ',
> +	260: 'H_VIO_SIGNAL',
> +	264: 'H_SEND_CRQ',
> +	272: 'H_COPY_RDMA',
> +	276: 'H_REGISTER_LOGICAL_LAN',
> +	280: 'H_FREE_LOGICAL_LAN',
> +	284: 'H_ADD_LOGICAL_LAN_BUFFER',
> +	288: 'H_SEND_LOGICAL_LAN',
> +	292: 'H_BULK_REMOVE',
> +	304: 'H_MULTICAST_CTRL',
> +	308: 'H_SET_XDABR',
> +	312: 'H_STUFF_TCE',
> +	316: 'H_PUT_TCE_INDIRECT',
> +	332: 'H_CHANGE_LOGICAL_LAN_MAC',
> +	336: 'H_VTERM_PARTNER_INFO',
> +	340: 'H_REGISTER_VTERM',
> +	344: 'H_FREE_VTERM',
> +	348: 'H_RESET_EVENTS',
> +	352: 'H_ALLOC_RESOURCE',
> +	356: 'H_FREE_RESOURCE',
> +	360: 'H_MODIFY_QP',
> +	364: 'H_QUERY_QP',
> +	368: 'H_REREGISTER_PMR',
> +	372: 'H_REGISTER_SMR',
> +	376: 'H_QUERY_MR',
> +	380: 'H_QUERY_MW',
> +	384: 'H_QUERY_HCA',
> +	388: 'H_QUERY_PORT',
> +	392: 'H_MODIFY_PORT',
> +	396: 'H_DEFINE_AQP1',
> +	400: 'H_GET_TRACE_BUFFER',
> +	404: 'H_DEFINE_AQP0',
> +	408: 'H_RESIZE_MR',
> +	412: 'H_ATTACH_MCQP',
> +	416: 'H_DETACH_MCQP',
> +	420: 'H_CREATE_RPT',
> +	424: 'H_REMOVE_RPT',
> +	428: 'H_REGISTER_RPAGES',
> +	432: 'H_DISABLE_AND_GETC',
> +	436: 'H_ERROR_DATA',
> +	440: 'H_GET_HCA_INFO',
> +	444: 'H_GET_PERF_COUNT',
> +	448: 'H_MANAGE_TRACE',
> +	468: 'H_FREE_LOGICAL_LAN_BUFFER',
> +	472: 'H_POLL_PENDING',
> +	484: 'H_QUERY_INT_STATE',
> +	580: 'H_ILLAN_ATTRIBUTES',
> +	592: 'H_MODIFY_HEA_QP',
> +	596: 'H_QUERY_HEA_QP',
> +	600: 'H_QUERY_HEA',
> +	604: 'H_QUERY_HEA_PORT',
> +	608: 'H_MODIFY_HEA_PORT',
> +	612: 'H_REG_BCMC',
> +	616: 'H_DEREG_BCMC',
> +	620: 'H_REGISTER_HEA_RPAGES',
> +	624: 'H_DISABLE_AND_GET_HEA',
> +	628: 'H_GET_HEA_INFO',
> +	632: 'H_ALLOC_HEA_RESOURCE',
> +	644: 'H_ADD_CONN',
> +	648: 'H_DEL_CONN',
> +	664: 'H_JOIN',
> +	676: 'H_VASI_STATE',
> +	688: 'H_ENABLE_CRQ',
> +	696: 'H_GET_EM_PARMS',
> +	720: 'H_SET_MPP',
> +	724: 'H_GET_MPP',
> +	748: 'H_HOME_NODE_ASSOCIATIVITY',
> +	756: 'H_BEST_ENERGY',
> +	764: 'H_XIRR_X',
> +	768: 'H_RANDOM',
> +	772: 'H_COP',
> +	788: 'H_GET_MPP_X',
> +	796: 'H_SET_MODE',
> +	61440: 'H_RTAS',
> +}
> +
> +def hcall_table_lookup(opcode):
> +	if (hcall_table.has_key(opcode)):
> +		return hcall_table[opcode]
> +	else:
> +		return opcode
> +
> +print_ptrn = '%-28s%10s%10s%10s%10s'
> +
> +def trace_end():
> +	print print_ptrn % ('hcall', 'count', 'min(ns)', 'max(ns)', 'avg(ns)')
> +	print '-' * 68
> +	for opcode in output:
> +		h_name = hcall_table_lookup(opcode)
> +		time = output[opcode]['time']
> +		cnt = output[opcode]['cnt']
> +		min_t = output[opcode]['min']
> +		max_t = output[opcode]['max']
> +
> +		print print_ptrn % (h_name, cnt, min_t, max_t, time/cnt)
> +
> +def powerpc__hcall_exit(name, context, cpu, sec, nsec, pid, comm, callchain,
> +			opcode, retval):
> +	if (d_enter.has_key(cpu) and d_enter[cpu].has_key(opcode)):
> +		diff = nsecs(sec, nsec) - d_enter[cpu][opcode]
> +
> +		if (output.has_key(opcode)):
> +			output[opcode]['time'] += diff
> +			output[opcode]['cnt'] += 1
> +			if (output[opcode]['min'] > diff):
> +				output[opcode]['min'] = diff
> +			if (output[opcode]['max'] < diff):
> +				output[opcode]['max'] = diff
> +		else:
> +			output[opcode] = {
> +				'time': diff,
> +				'cnt': 1,
> +				'min': diff,
> +				'max': diff,
> +			}
> +
> +		del d_enter[cpu][opcode]
> +#	else:
> +#		print "Can't find matching hcall_enter event. Ignoring sample"
> +
> +def powerpc__hcall_entry(event_name, context, cpu, sec, nsec, pid, comm,
> +			 callchain, opcode):
> +		if (d_enter.has_key(cpu)):
> +			d_enter[cpu][opcode] = nsecs(sec, nsec)
> +		else:
> +			d_enter[cpu] = {opcode: nsecs(sec, nsec)}
> 

PC
