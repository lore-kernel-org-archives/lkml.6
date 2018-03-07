Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu9kw7SsUstE0Rkk0rSM/veb3qRCrlPbR96KssC4YwBRBJSNtg3K6wM80M/Mi0zcK3mgyBC
ARC-Seal: i=1; a=rsa-sha256; t=1520452046; cv=none;
        d=google.com; s=arc-20160816;
        b=jzr2+rTqgtNhB5aSoYgganFINYA/x0j27QbgnUnaoU5ZGORX8uv2PH9HKCGRGpklPH
         aDDC8G8LDb8saQsv9y8KbW9ng0EoYJEGz+5ifsS1upWBi/pEjzvFP6yJsX+XvB9Wuvru
         pqzRPmNCdXhH4AvSYW/Y9c5bA2LcFeFAejABikkwOWcaFBhaSLy6wcv3XL9QgyjItVYU
         3+j0UiNECQ+bKndCS5+u1wWN4p3xDb9ZYQbXy3VqVDZO720Q4bWdV5xS7tTByLLEup9i
         RneEGxdd4QhOs6ZrEgi9S4Q8m1QvH9Uz8eoPgJdfaO+v+BJS11+HroGwlHMuiJ7SD6wd
         3gNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Fp1ZZnoL6vFLX0oL2jhe/Wuai+jMNgj/LQv0lre36Cg=;
        b=NF7gC3UjygCYGiFuzGJEhBFVWEO6NTHiccDcQ1/eBAGB7uG+tMNupCeU0CLdtnjvrl
         FGP27a6mWbBINvAlQRh+GPXgUee951c7D/F2U8zzUabHYq3wiBK3VlyLWSQnF90gaMUe
         EvyCa7c8345ngp3cpXx0JMBKFANzgi190NEA/LU5v2rFhcyGd+jgWHGldtltKHX9zUIF
         vHS+X7xvB5V84eyj++sZPu2iEmZO7WJvggxzfG2OFvmaP+kh7p+m00raKVLZPjtMGagw
         19s5QfYpXQxHKnuNhwmeZPS6Fb8Rif6pvUViGIppms2KBwXbwMbXH+8GnxFnpQwnlfwz
         x00A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Anna Karbownik <anna.karbownik@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	jim.m.snow@intel.com,
	krzysztof.paliswiat@intel.com,
	lukasz.odzioba@intel.com,
	qiuxu.zhuo@intel.com,
	linux-edac <linux-edac@vger.kernel.org>,
	Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.14 085/110] EDAC, sb_edac: Fix out of bound writes during DIMM configuration on KNL
Date: Wed,  7 Mar 2018 11:39:08 -0800
Message-Id: <20180307191050.728230640@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309271673449358?=
X-GMAIL-MSGID: =?utf-8?q?1594309525942267265?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anna Karbownik <anna.karbownik@intel.com>

commit bf8486709ac7fad99e4040dea73fe466c57a4ae1 upstream.

Commit

  3286d3eb906c ("EDAC, sb_edac: Drop NUM_CHANNELS from 8 back to 4")

decreased NUM_CHANNELS from 8 to 4, but this is not enough for Knights
Landing which supports up to 6 channels.

This caused out-of-bounds writes to pvt->mirror_mode and pvt->tolm
variables which don't pay critical role on KNL code path, so the memory
corruption wasn't causing any visible driver failures.

The easiest way of fixing it is to change NUM_CHANNELS to 6. Do that.

An alternative solution would be to restructure the KNL part of the
driver to 2MC/3channel representation.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Anna Karbownik <anna.karbownik@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: jim.m.snow@intel.com
Cc: krzysztof.paliswiat@intel.com
Cc: lukasz.odzioba@intel.com
Cc: qiuxu.zhuo@intel.com
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: <stable@vger.kernel.org>
Fixes: 3286d3eb906c ("EDAC, sb_edac: Drop NUM_CHANNELS from 8 back to 4")
Link: http://lkml.kernel.org/r/1519312693-4789-1-git-send-email-anna.karbownik@intel.com
[ Massage commit message. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/edac/sb_edac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -279,7 +279,7 @@ static const u32 correrrthrsld[] = {
  * sbridge structs
  */
 
-#define NUM_CHANNELS		4	/* Max channels per MC */
+#define NUM_CHANNELS		6	/* Max channels per MC */
 #define MAX_DIMMS		3	/* Max DIMMS per channel */
 #define KNL_MAX_CHAS		38	/* KNL max num. of Cache Home Agents */
 #define KNL_MAX_CHANNELS	6	/* KNL max num. of PCI channels */
