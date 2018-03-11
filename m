Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932475AbeCKWBa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 18:01:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932426AbeCKWB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 18:01:28 -0400
Subject: Re: [PATCH 1/2] security: evm: Move evm_hmac and evm_hash from
 evm_main.c to evm_crypto.c
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>,
        jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Mar 2018 18:01:18 -0400
In-Reply-To: <1519769820-20365-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1519769820-20365-1-git-send-email-hernan@vanguardiasur.com.ar>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18031122-0040-0000-0000-0000041E11FA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031122-0041-0000-0000-000026213679
Message-Id: <1520805678.3547.8.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-11_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803110281
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-27 at 19:16 -0300, Hernán Gonzalez wrote:
> Note: This is compile only tested.
> This variable was not used where it was defined, there was no point in
> declaring it there as extern, thus it got moved and constified saving up 2
> bytes.
> 
> Function                                     old     new   delta
> init_desc                                    273     271      -2
> Total: Before=2112094, After=2112092, chg -0.00%
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>

Thanks, both patches have been applied.

Mimi

> ---
>  security/integrity/evm/evm.h        | 2 --
>  security/integrity/evm/evm_crypto.c | 3 +++
>  security/integrity/evm/evm_main.c   | 2 --
>  3 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
> index 0482539..45c4a89 100644
> --- a/security/integrity/evm/evm.h
> +++ b/security/integrity/evm/evm.h
> @@ -31,8 +31,6 @@
>  		       EVM_ALLOW_METADATA_WRITES)
> 
>  extern int evm_initialized;
> -extern char *evm_hmac;
> -extern char *evm_hash;
> 
>  #define EVM_ATTR_FSUUID		0x0001
> 
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index 691f3e0..fdde9cb 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -37,6 +37,9 @@ static DEFINE_MUTEX(mutex);
> 
>  static unsigned long evm_set_key_flags;
> 
> +char * const evm_hmac = "hmac(sha1)";
> +char * const evm_hash = "sha1";
> +
>  /**
>   * evm_set_key() - set EVM HMAC key from the kernel
>   * @key: pointer to a buffer with the key data
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index a8d5028..826926d 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -33,8 +33,6 @@ int evm_initialized;
>  static char *integrity_status_msg[] = {
>  	"pass", "pass_immutable", "fail", "no_label", "no_xattrs", "unknown"
>  };
> -char *evm_hmac = "hmac(sha1)";
> -char *evm_hash = "sha1";
>  int evm_hmac_attrs;
> 
>  char *evm_config_xattrnames[] = {
