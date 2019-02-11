Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A38C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BDC21B24
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfBKQsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:48:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:47093 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728968AbfBKQsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:48:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 08:48:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="scan'208";a="114050317"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.142])
  by orsmga007.jf.intel.com with ESMTP; 11 Feb 2019 08:48:04 -0800
Date:   Mon, 11 Feb 2019 18:48:03 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, PeterHuewe@gmx.de,
        jgg@ziepe.ca
Subject: Re: [PATCH 2/2] selftests: tpm2: Extend tests to cover partial reads
Message-ID: <20190211164803.GG8431@linux.intel.com>
References: <154939851385.18477.481518864800562919.stgit@tstruk-mobl1.jf.intel.com>
 <154939851969.18477.13778157467131576825.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154939851969.18477.13778157467131576825.stgit@tstruk-mobl1.jf.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You are missing a cover letter from this patch set. Please have it in
v2. Also use tag "selftests/tpm2" instead of having two tags in the
short summaries. Now they look a bit weird.

On Tue, Feb 05, 2019 at 12:28:39PM -0800, Tadeusz Struk wrote:
> Three new tests added:
> 1. Send get random cmd, read header in 1st read, read the rest in second
>    read - expect success
> 2. Send get random cmd, read only part of the response, send another
>    get random command, read the response - expect success
> 3. Send get random cmd followed by another get random cmd, without
>    reading the first response - expect the second cmd to fail with -EBUSY
> 
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> ---
>  tools/testing/selftests/tpm2/tpm2.py       |    1 
>  tools/testing/selftests/tpm2/tpm2_tests.py |   82 ++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/tools/testing/selftests/tpm2/tpm2.py b/tools/testing/selftests/tpm2/tpm2.py
> index c2b9f2b1a0ac..828c18584624 100644
> --- a/tools/testing/selftests/tpm2/tpm2.py
> +++ b/tools/testing/selftests/tpm2/tpm2.py
> @@ -22,6 +22,7 @@ TPM2_CC_UNSEAL = 0x015E
>  TPM2_CC_FLUSH_CONTEXT = 0x0165
>  TPM2_CC_START_AUTH_SESSION = 0x0176
>  TPM2_CC_GET_CAPABILITY	= 0x017A
> +TPM2_CC_GET_RANDOM = 0x017B
>  TPM2_CC_PCR_READ = 0x017E
>  TPM2_CC_POLICY_PCR = 0x017F
>  TPM2_CC_PCR_EXTEND = 0x0182
> diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
> index 3bb066fea4a0..3f6a65cbdd39 100644
> --- a/tools/testing/selftests/tpm2/tpm2_tests.py
> +++ b/tools/testing/selftests/tpm2/tpm2_tests.py
> @@ -158,6 +158,88 @@ class SmokeTest(unittest.TestCase):
>              pass
>          self.assertEqual(rejected, True)
>  
> +    def test_read_partial_resp(self):
> +        """Reads random in two subsequent reads"""
> +        log = logging.getLogger(__name__)
> +        try:
> +            fmt = '>HIIH'
> +            cmd = struct.pack(fmt,
> +                              tpm2.TPM2_ST_NO_SESSIONS,
> +                              struct.calcsize(fmt),
> +                              tpm2.TPM2_CC_GET_RANDOM,
> +                              0x20)
> +            self.client.tpm.write(cmd)
> +            hdr = self.client.tpm.read(10)
> +            sz = struct.unpack('>I', hdr[2:6])[0]
> +            rsp = self.client.tpm.read()

8<

> +            log.debug("header:")
> +            log.debug(tpm2.hex_dump(hdr))
> +            log.debug("resp:")
> +            log.debug(tpm2.hex_dump(rsp))

Remove.

> +        except:

8<

> +            log.debug("Error:", sys.exc_info()[0])

Remove.

> +            raise
> +
> +        self.assertEqual(sz, 10 + 2 + 32)
> +        self.assertEqual(len(rsp), 2 + 32)
> +
> +    def test_read_partial_overwrite(self):
> +        """Reads only part of the response and issue a new cmd"""
> +        log = logging.getLogger(__name__)
> +        try:
> +            fmt = '>HIIH'
> +            cmd = struct.pack(fmt,
> +                              tpm2.TPM2_ST_NO_SESSIONS,
> +                              struct.calcsize(fmt),
> +                              tpm2.TPM2_CC_GET_RANDOM,
> +                              0x20)
> +            self.client.tpm.write(cmd)
> +            # Read part of the respone
> +            rsp1 = self.client.tpm.read(15)

8<

> +            log.debug("rsp 1:")
> +            log.debug(tpm2.hex_dump(rsp1))

Remove.

> +
> +            # Send a new cmd
> +            self.client.tpm.write(cmd)
> +
> +            # Read the whole respone
> +            rsp2 = self.client.tpm.read()

8<

> +            log.debug("rsp 2:")
> +            log.debug(tpm2.hex_dump(rsp2))

Remove.

> +
> +        except:

8<
> +            log.debug("Error:", sys.exc_info()[0])

Remove.

> +            raise
> +
> +        self.assertEqual(len(rsp1), 15)
> +        self.assertEqual(len(rsp2), 10 + 2 + 32)
> +
> +    def test_send_two_cmds(self):
> +        """Send two cmds without reading a response"""
> +        rejected = False
> +        try:
> +            fmt = '>HIIH'
> +            cmd = struct.pack(fmt,
> +                              tpm2.TPM2_ST_NO_SESSIONS,
> +                              struct.calcsize(fmt),
> +                              tpm2.TPM2_CC_GET_RANDOM,
> +                              0x20)
> +            self.client.tpm.write(cmd)
> +
> +            # expect the second one to raise -EBUSY error
> +            self.client.tpm.write(cmd)
> +            rsp = self.client.tpm.read()
> +
> +        except IOError, e:
> +            # read the response
> +            rsp = self.client.tpm.read()
> +            rejected = True
> +            pass
> +        except:
> +            raise
> +
> +        self.assertEqual(rejected, True)
> +
>  class SpaceTest(unittest.TestCase):
>      def setUp(self):
>          logging.basicConfig(filename='SpaceTest.log', level=logging.DEBUG)
> 

/Jarkko
