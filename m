Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48kPtlH/2FqGdTVQ+d7ZeaNzdx9Chie0Br/9QV54tPokxlodezj4ES3H/peEryddzulP/Bz
ARC-Seal: i=1; a=rsa-sha256; t=1524405686; cv=none;
        d=google.com; s=arc-20160816;
        b=ohRs26tKeCctr3b7p2KbTt+jSOxW96y776AddMmqmDK5NP6d0DlDnnxCAj+qgUKeF5
         a2FthLt+bB/jdVBovLT5frUvAe1LmNRd+C4fSeIhKO3yV3t6cqAHMkdbw67YhrmN8S8P
         UJjpTvK5a9Zq5yAFTGUjlud4LKm/ygKjzVK2ZiPzNVjChzDCRMpiL7+6U2ODguiF2tx1
         LjeDDaKzkGm/rR9LiRFwi20RlXD6UkdTKgsWl8gNZXMvl/TMHyp1SS2OPiMnqPg73gLy
         SDxnRw/QueZ9wxdLI8BrKPqTg4o7SSzlGaVMPvZaekAbZHQmq1In1QwFyLljJ/D+0rST
         VZbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=T2dv/fGe84mSUwMuGrO5PaR0JlUHjuesn5uhZNitj6s=;
        b=lhdKV2yityD4G8YUtD4EwcgaoW2qdJItVbktQv6SDgirCz5IaozsakI/o+yeU//70k
         21cMkH72nEqE0rEci6Gk52MPqpzJY80Jd0is8GIiMGVNRWE7NQFwmHNngimZmVDfZsPp
         OMPwwubkf8Y/9J+QQqovU45OHTZEUSvrJSzr2wJ5HqvRomAOWBT1w1oDKvOf9skuBuEq
         plJHUwCyd/U+RoPCyHL0B9DygiN/VTu3N8IFnWJvfL1qrfc20tbxZVvhTWgxy5kFZrjy
         XkU3cW+rtxxoLPzf9FHYtSguLFRGjuw5MJd9A/QSBZ9V61hEPTKJOM5E0c2WLK8WbvMO
         RFpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Krzysztof Rusocki <krzysztof.rusocki@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.16 122/196] libnvdimm, dimm: fix dpa reservation vs uninitialized label area
Date: Sun, 22 Apr 2018 15:52:22 +0200
Message-Id: <20180422135110.562601461@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455217087202947?=
X-GMAIL-MSGID: =?utf-8?q?1598455217087202947?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit c31898c8c711f2bbbcaebe802a55827e288d875a upstream.

At initialization time the 'dimm' driver caches a copy of the memory
device's label area and reserves address space for each of the
namespaces defined.

However, as can be seen below, the reservation occurs even when the
index blocks are invalid:

 nvdimm nmem0: nvdimm_init_config_data: len: 131072 rc: 0
 nvdimm nmem0: config data size: 131072
 nvdimm nmem0: __nd_label_validate: nsindex0 labelsize 1 invalid
 nvdimm nmem0: __nd_label_validate: nsindex1 labelsize 1 invalid
 nvdimm nmem0: : pmem-6025e505: 0x1000000000 @ 0xf50000000 reserve <-- bad

Gate dpa reservation on the presence of valid index blocks.

Cc: <stable@vger.kernel.org>
Fixes: 4a826c83db4e ("libnvdimm: namespace indices: read and validate")
Reported-by: Krzysztof Rusocki <krzysztof.rusocki@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvdimm/dimm.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/nvdimm/dimm.c
+++ b/drivers/nvdimm/dimm.c
@@ -67,9 +67,11 @@ static int nvdimm_probe(struct device *d
 	ndd->ns_next = nd_label_next_nsindex(ndd->ns_current);
 	nd_label_copy(ndd, to_next_namespace_index(ndd),
 			to_current_namespace_index(ndd));
-	rc = nd_label_reserve_dpa(ndd);
-	if (ndd->ns_current >= 0)
-		nvdimm_set_aliasing(dev);
+	if (ndd->ns_current >= 0) {
+		rc = nd_label_reserve_dpa(ndd);
+		if (rc == 0)
+			nvdimm_set_aliasing(dev);
+	}
 	nvdimm_clear_locked(dev);
 	nvdimm_bus_unlock(dev);
 
